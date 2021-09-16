using Microsoft.AspNetCore.Mvc;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "Is Leap Year", Version = "v1" });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Is Leap Year v1");
    c.RoutePrefix = string.Empty;
}
    );


app.MapGet("/isLeapYear", (HttpContext http, [FromQuery] DateTime? date, [FromQuery] int? year) =>
 {
     switch (date, year)
     {
         case (DateTime d, null): http.Response.WriteAsJsonAsync(d.IsLeapYear()); break;
         case (null, int y): http.Response.WriteAsJsonAsync(y.IsLeapYear()); break;
         default:
             http.Response.StatusCode = 400;
             http.Response.WriteAsJsonAsync(new { Error = "specify date or year not both" });
             break;
     }
 });

app.Run();


