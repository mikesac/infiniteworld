<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" />

	<xsl:template match="/">
					<div>
						<xsl:apply-templates select="//monster" />
					</div>
	</xsl:template>

</xsl:stylesheet>