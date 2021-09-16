<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Resharper InspectCode Report</title>
                <link  type="text/css"  href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous" />
            </head>
            <body class="d-flex flex-column min-vh-100 bg-light">


                <!-- Header-->
                <header class="bg-dark py-5">
                    <div class="container px-5">
                        <div class="row gx-5 justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center my-5">
                                    <img class="d-block mx-auto mb-4" src="https://upload.wikimedia.org/wikipedia/commons/a/af/ReSharper_Icon.png" alt="" height="100" />
                                    <h1 class="display-5 fw-bolder text-white mb-2">Resharper Duplicate Report</h1>

                                </div>
                            </div>
                        </div>
                    </div>
                </header>
                <content class="bg-light py-5">
                <div class="container">
                <h1>Statistics</h1>
                <p>Total codebase size: <xsl:value-of select="//CodebaseCost"/></p>
                <p>Code to analyze: <xsl:value-of select="//TotalDuplicatesCost"/></p>
                <p>Total size of duplicated fragments: <xsl:value-of select="//TotalFragmentsCost" /></p>
                <h1>Detected Duplicates</h1>
                <xsl:for-each select="//Duplicates/Duplicate">
                    <h2>Duplicated Code. Size: <xsl:value-of  select="@Cost"/></h2>
                    <h3>Duplicated Fragments:</h3>
                    <xsl:for-each select="Fragment">
                        <xsl:variable name="i" select="position()"/>
                        <p>Fragment <xsl:value-of select="$i"/>  in file <xsl:value-of select="FileName"/></p>
                        <pre><xsl:value-of select="Text"/></pre>
                    </xsl:for-each>
                </xsl:for-each>
                </div>
                </content>
                <!-- Footer-->
                <footer class="mt-auto py-5 bg-dark">
                    <div class="container px-5">
                        <p class="m-0 text-center text-white">Made with 💝 by evilz</p>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>