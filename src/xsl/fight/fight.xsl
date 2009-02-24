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
						<xsl:apply-templates select="//fight" />
					</div>
				</center>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="//fight">
		<table class="party">
			<tr>
				<td align="left">
					<table class="party1 firstParty">
						<tr>
							<td nowrap="nowrap" colspan="2">First Party</td>
						</tr>
						<tr>
							<xsl:apply-templates select="//firstside/monster" />
						</tr>
					</table>
				</td>
				<td align="right">
					<table class="party2  secondParty">
						<tr colspan="2">
							<td nowrap="nowrap">Second Party</td>
						</tr>
						<tr>
							<xsl:apply-templates select="//secondside/monster" />
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="fight">
			<xsl:apply-templates select="//round" />
		</div>
	</xsl:template>

	<xsl:template match="//round">
		<div class="round">
			<div class="lgnd">
				Round
				<xsl:value-of select="@num" />
			</div>

			<table>
				<xsl:apply-templates select="./attack" />
			</table>

		</div>
	</xsl:template>

	<xsl:template match="monster">
		<td>
			<xsl:choose>
				<xsl:when test="@first='true'">
					<xsl:attribute name="class">firstParty</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">secondParty</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<img width="50" height="50">
				<xsl:attribute name="src">imgs/monster/<xsl:value-of
					select="@img" />.png</xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="@name" /></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="@name" /></xsl:attribute>
			</img>
		</td>
		<td valign="top" nowrap="nowrap">
			<xsl:choose>
				<xsl:when test="@first='true'">
					<xsl:attribute name="class">firstParty</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">secondParty</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<table class="points">
				<tr><td>HP</td><td><div class="thp">
				<div class="chp">
					<xsl:attribute name="style">width:<xsl:value-of
						select="(@chp*100)div@thp" />;</xsl:attribute>
				</div>
				<div class="hpt">
					<xsl:value-of select="@chp" />
					/
					<xsl:value-of select="@thp" />
				</div>
			</div></td></tr>
				<tr><td>MP</td><td><div class="tmp">
				<div class="cmp">
					<xsl:attribute name="style">width:<xsl:value-of
						select="(@cmp*100)div@tmp" />;</xsl:attribute>
				</div>
				<div class="mpt">
					<xsl:value-of select="@cmp" />
					/
					<xsl:value-of select="@tmp" />
				</div>
			</div></td></tr>
				<tr><td>AP</td><td><div class="tap">
				<div class="cap">
					<xsl:attribute name="style">width:<xsl:value-of
						select="(@cap*100)div@tap" />;</xsl:attribute>
				</div>
				<div class="apt">
					<xsl:value-of select="@cap" />
					/
					<xsl:value-of select="@tap" />
				</div>
			</div></td></tr>
			</table>
			
			
			
			
			
		</td>
	</xsl:template>

	<xsl:template match="attack">
		<tr nowrap="nowrap">
			<xsl:apply-templates select="./monster[@type='attacker']" />
			<xsl:apply-templates select="./melee" />
			<xsl:apply-templates select="./magic" />
			<xsl:apply-templates select="./idle" />
			<xsl:apply-templates select="./monster[@type='defender']" />
			<xsl:apply-templates select="./death" />
		</tr>
	</xsl:template>


	<xsl:template match="melee">
		<td>
			<img width="50">
				<xsl:attribute name="src">./imgs/item/<xsl:value-of
					select="@img" />.png</xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="@type" /></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="@type" /></xsl:attribute>
			</img>
		</td>
		<td class="d20r" valign="top">
			<xsl:value-of select="@roll" />
		</td>
		<td>

			<xsl:choose>
				<xsl:when test="@hit=1">
					<p class="hit">
						Hit for
						<xsl:value-of select="@dmg" />
						HP
					</p>
				</xsl:when>
				<xsl:otherwise>
					<p class="miss">missed</p>
				</xsl:otherwise>
			</xsl:choose>

		</td>
		<td class="shield" valign="top">
			<xsl:value-of select="@ca" />
		</td>

	</xsl:template>

	<xsl:template match="magic">
	<td>
			<img width="50">
				<xsl:attribute name="src">./imgs/spell/<xsl:value-of
					select="@img" />.png</xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="@name" /></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="@name" /></xsl:attribute>
			</img>
		</td>
		<td colspan="3">
			<center><xsl:choose>
				<xsl:when test="@type=0">
					<p class="hit">
						Hit for
						<xsl:value-of select="@dmg" />
						HP
					</p>
				</xsl:when>
				<xsl:otherwise>
					<p class="miss">Healed for
						<xsl:value-of select="@dmg" />
						HP</p>
				</xsl:otherwise>
			</xsl:choose></center>
		</td>
	</xsl:template>
	
	<xsl:template match="idle">
		<td colspan="4" class="rest">Attacker need to rest!<br/>Round skipped</td>
	</xsl:template>

	<xsl:template match="death">
		<td>
			<img width="50" heigth="50" src="./imgs/web/die.png" alt="opponent dies" title="opponent dies" />
		</td>
		<td>
		<table class="rewards">
			<tr><td><img width="15" src="./imgs/web/gc.gif"/></td><td>Gold</td><td><xsl:value-of select="./gold" /></td></tr>
			<tr><td><img width="15" src="./imgs/web/px.gif"/></td><td>Experience</td><td><xsl:value-of select="./xp" /></td></tr>
			<tr><td><img width="15" src="./imgs/web/loot.png"/></td><td>Items</td><td><xsl:value-of select="./items" /></td></tr>
		</table>
		</td>
	</xsl:template>

</xsl:stylesheet>