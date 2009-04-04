<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" />

	<xsl:template match="/spell">
			<table>
				<tr>
					<td colspan="4">
						<xsl:value-of select="./name" />
					</td>
				</tr>
				<tr>
					<td>
						<img>
							<xsl:attribute name="src">../imgs/spell/<xsl:value-of
								select="./image" />.png</xsl:attribute>
						</img>
					</td>
					<td colspan="3">
						<xsl:value-of select="./desc" />
					</td>
				</tr>
								<tr>
					<td colspan="4">Details</td>
				</tr>
				<tr>
					<td>Mana Cost</td>
					<td>
						<xsl:value-of select="./costMp" />
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="./damage=0">
								Damage
							</xsl:when>
							<xsl:otherwise>
								Heal
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:value-of select="./damage" />
					</td>
				</tr>
				<tr>
					<td>Duration</td>
					<td>
						<xsl:value-of select="./duration" />
					</td>
					<td>Saving Throw</td>
					<td>
						<xsl:value-of select="./savingthrow" />
					</td>
				</tr>

				<tr>
					<td>Level</td>
					<td>
						<xsl:value-of select="./lev" />
					</td>
					<td>Initiative</td>
					<td>
						<xsl:value-of select="./initiative" />
					</td>
				</tr>
				<tr>
					<td colspan="4">Required</td>
				</tr>
				<tr>
					<td>Strength</td>
					<td>
						<xsl:value-of select="./reqStr" />
					</td>
					<td>Intelligence</td>
					<td>
						<xsl:value-of select="./reqInt" />
					</td>
				</tr>
				<tr>
					<td>Dexterity</td>
					<td>
						<xsl:value-of select="./reqDex" />
					</td>
					<td>Charisma</td>
					<td>
						<xsl:value-of select="./reqCha" />
					</td>
				</tr>

				<tr>
					<td colspan="4">Modificators</td>
				</tr>
				<tr>
					<td>Strength</td>
					<td>
						<xsl:value-of select="./modStr" />
					</td>
					<td>Intelligence</td>
					<td>
						<xsl:value-of select="./modInt" />
					</td>
				</tr>
				<tr>
					<td>Dexterity</td>
					<td>
						<xsl:value-of select="./modDex" />
					</td>
					<td>Charisma</td>
					<td>
						<xsl:value-of select="./modCha" />
					</td>
				</tr>
			</table>
	</xsl:template>
</xsl:stylesheet>