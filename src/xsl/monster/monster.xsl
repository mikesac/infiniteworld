<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" />

	<xsl:template match="/">
		<html>
			<link rel="stylesheet" type="text/css" href="/InfiniteWeb/out/fight.css" />
			<body>
				<center>
					<div>
						<xsl:apply-templates select="//monster" />
					</div>
				</center>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="monster">
		<div class="monster">
			<table>
				<tr>
					<td colspan="2" align="center">
						<div class="lgnd">
							<xsl:value-of select="./name" />
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2"  class="pediadesc">
						<xsl:value-of select="./description" />
					</td>
				</tr>
				<tr>
					<td>
						<img class="bigimg" width="300px">
							<xsl:attribute name="src">/InfiniteWeb/imgs/monster/big/<xsl:value-of
								select="./image" />.png</xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of
								select="./name" /></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of
								select="./name" /></xsl:attribute>
						</img>
					</td>
					<td valign="top" align="center">
						<table class="pediastats">
							<tr>
								<td>Name</td>
								<td>
									<xsl:value-of select="./name" />
								</td>
							</tr>
							<tr>
								<td>Level</td>
								<td>
									<xsl:value-of select="./level" />
								</td>
							</tr>
						</table>
						<table class="pediastats">
							<tr>
								<td>Strength</td>
								<td>
									<xsl:value-of select="./baseStr" />
								</td>
							</tr>
							<tr>
								<td>Intelligence</td>
								<td>
									<xsl:value-of select="./baseInt" />
								</td>
							</tr>
							<tr>
								<td>Dexterity</td>
								<td>
									<xsl:value-of select="./baseDex" />
								</td>
							</tr>
							<tr>
								<td>Charisma</td>
								<td>
									<xsl:value-of select="./baseCha" />
								</td>
							</tr>

						</table>
						<table class="pediastats">
							<tr>
								<td>Life Points</td>
								<td>
									<xsl:value-of select="./basePl" />
								</td>
							</tr>
							<tr>
								<td>Magic Points</td>
								<td>
									<xsl:value-of select="./basePm" />
								</td>
							</tr>
							<tr>
								<td>Action Points</td>
								<td>
									<xsl:value-of select="./basePa" />
								</td>
							</tr>
							<tr>
								<td>Charm Points</td>
								<td>
									<xsl:value-of select="./basePc" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

		</div>
	</xsl:template>

</xsl:stylesheet>