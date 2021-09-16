FROM mcr.microsoft.com/dotnet/nightly/sdk:6.0.100-rc.1-focal AS build

ARG VERSION=0.0.0.1
RUN echo "⚡⚡⚡⚡ DOCKER BUILD IN VERSION $VERSION ⚡⚡⚡⚡" > /dev/null

WORKDIR /source


# copy csproj and restore as distinct layers
COPY *.sln .

COPY ./src/**.csproj ./src/
COPY ./test/**.csproj ./test/
COPY ./.config ./.config

RUN echo "⏬ RESTORE" > /dev/null
RUN dotnet restore
RUN dotnet tool restore

# copy everything else
COPY ./ ./

# BUILD
RUN echo "🔨 BUILD" > /dev/null
RUN dotnet build -c release --no-restore

# UNIT TEST + REPORT
RUN echo "🧪 TEST" > /dev/null
RUN dotnet test -c release --no-build  /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura  /p:CoverletOutput="../artifacts/coverage.xml" --test-adapter-path:. --logger:"junit;LogFilePath=../artifacts/test-result.xml;MethodFormat=Class;FailureBodyFormat=Verbose"
RUN dotnet reportgenerator "-reports:./artifacts/coverage.xml" "-targetdir:./artifacts/testreport" "-reporttypes:Html"

# RESHARPER ANALYSE
RUN dotnet jb inspectcode ./LeapYear.sln -o=inspectcode.xml --no-build
RUN dotnet jb dupfinder ./src -o=dupfinder.xml --no-build

RUN dotnet fsi xslt.fsx inspectcode.xml ic.xslt "./artifacts/inspectcode.html"
RUN dotnet fsi xslt.fsx dupfinder.xml df.xslt "./artifacts/dupfinder.html"
COPY ./index.html ./artifacts/index.html


# PUBLISH NUGET OR APP ...
RUN echo "📦 PUBLISH" > /dev/null
RUN dotnet publish ./src/LeapYear.csproj -c release -o ./out --no-restore /p:Version=$VERSION

# -r linux-x64 
#RUN dotnet publish ./src/o2-smac-spot/o2-smac-spot.fsproj -c release -o /app -r linux-musl-x64 --no-restore
#--self-contained true /p:PublishTrimmed=true /p:PublishReadyToRun=true


# build runtime image
RUN echo "🐳 DOCKER IMAGE" > /dev/null
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
ENV ASPNETCORE_URLS=http://+:5000
WORKDIR /app
COPY --from=build /source/out ./
EXPOSE 5000
ENTRYPOINT ["dotnet", "LeapYear.dll"]
