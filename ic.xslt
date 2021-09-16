<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:key name="ISSUETYPES" match="/Report/Issues/Project/Issue" use="@TypeId"/>
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/" name="TopLevelReport">
 
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
                                <h1 class="display-5 fw-bolder text-white mb-2">Resharper InspectCode Report</h1>
                              
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <content class="bg-light py-5">
     

        <div class="container">
                <div class="accordion accordion-flush" >
        <xsl:for-each select="/Report/IssueTypes/IssueType">
            <div class="accordion-item">
            <h2 class="accordion-header" >
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                    <xsl:attribute name="data-bs-target">#<xsl:value-of select="@Id" /></xsl:attribute>
                    <span >
                        <xsl:choose>
                            <xsl:when test="@Severity = 'SUGGESTION'">
                                <xsl:attribute name="class">badge bg-info text-dark</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="@Severity = 'WARNING'">
                                <xsl:attribute name="class">badge bg-warning text-dark</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="@Severity = 'ERROR'">
                                <xsl:attribute name="class">badge bg-danger</xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="class">rowTypeOther"</xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="@Severity"/>

                    </span>: <xsl:value-of select="@Description"/>
                </button>
              
          </h2>
                <div class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
                    <xsl:attribute name="id"><xsl:value-of select="@Id" /></xsl:attribute>
                    <div class="accordion-body">
                        <table class="table table-hover" style="width:100%">


                            <thead class="table-dark">
                                <tr>
                                    <th>File</th>
                                    <th>Line Number</th>
                                    <th>Message</th>
                                </tr>
                            </thead>
                            <xsl:for-each select="key('ISSUETYPES',@Id)">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@File"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="@Line"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="@Message"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                </div>
         
            </div>
          <br />
          
          <br />
        </xsl:for-each>
        </div>
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
