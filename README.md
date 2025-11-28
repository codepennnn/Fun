<?xml version="1.0" encoding="utf-8"?>
<Report xmlns="http://schemas.microsoft.com/sqlserver/reporting/2008/01/reportdefinition"
        xmlns:rd="http://schemas.microsoft.com/SQLServer/reporting/reportdesigner">
	<AutoRefresh>0</AutoRefresh>
	<DataSources>
		<DataSource Name="DataSet1">
			<DataSourceReference>/* Leave empty: use LocalReport.DataSources in code */</DataSourceReference>
			<rd:DataSourceID>DataSource-DataSet1</rd:DataSourceID>
		</DataSource>
	</DataSources>

	<Body>
		<ReportItems>
			<Textbox Name="ReportTitle">
				<CanGrow>true</CanGrow>
				<KeepTogether>true</KeepTogether>
				<Paragraphs>
					<Paragraph>
						<TextRuns>
							<TextRun>
								<Value>Half Yearly Labour Return</Value>
								<Style>
									<FontSize>14pt</FontSize>
									<FontWeight>Bold</FontWeight>
								</Style>
							</TextRun>
						</TextRuns>
						<Style />
					</Paragraph>
				</Paragraphs>
				<Top>0.1in</Top>
				<Left>0.1in</Left>
				<Height>0.3in</Height>
				<Width>7.4in</Width>
				<Style>
					<TextAlign>Center</TextAlign>
				</Style>
			</Textbox>

			<!-- Main form table (two columns: Label / Value) -->
			<Tablix Name="TablixForm">
				<TablixBody>
					<TablixColumns>
						<TablixColumn>
							<Width>2.4in</Width>
						</TablixColumn>
						<TablixColumn>
							<Width>4.9in</Width>
						</TablixColumn>
					</TablixColumns>

					<TablixRows>
						<!-- We'll create one row per field -->
						<!-- Row template repeated for each field in order -->
					

						<!-- 2 -->
						<TablixRow>
							<Height>0.22in</Height>
							<TablixCells>
								<TablixCell>
									<CellContents>
										<Textbox Name="Label_Name_Address_Of_Contractor">
											<Value>Name &amp; Address of Contractor</Value>
											<Style>
												<FontWeight>Bold</FontWeight>
											</Style>
										</Textbox>
									</CellContents>
								</TablixCell>
								<TablixCell>
									<CellContents>
										<Textbox Name="Value_Name_Address_Of_Contractor">
											<Value>=Fields!Name_Address_Of_Contractor.Value</Value>
										</Textbox>
									</CellContents>
								</TablixCell>
							</TablixCells>
						</TablixRow>
