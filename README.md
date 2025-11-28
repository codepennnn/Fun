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
            <!-- 1 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_ID">
                      <Value>ID</Value>
                      <Style>
                        <FontWeight>Bold</FontWeight>
                      </Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_ID">
                      <Value>=Fields!ID.Value</Value>
                      <Style />
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

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

            <!-- 3 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Name_and_Address_Of_PrincipalEmp">
                      <Value>Name &amp; Address of Principal Employer</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Name_and_Address_Of_PrincipalEmp">
                      <Value>=Fields!Name_and_Address_Of_PrincipalEmp.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 4 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Duration_Of_Contract">
                      <Value>Duration Of Contract</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Duration_Of_Contract">
                      <Value>=Fields!Duration_Of_Contract.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 5 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Establishment_Of_Principal_Emp_Worked">
                      <Value>Establishment Of Principal Emp Worked</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Establishment_Of_Principal_Emp_Worked">
                      <Value>=Fields!Establishment_Of_Principal_Emp_Worked.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 6 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Contractors_Establishment_Worked">
                      <Value>Contractors Establishment Worked</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Contractors_Establishment_Worked">
                      <Value>=Fields!Contractors_Establishment_Worked.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 7 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Max_No_Contractor_Labour_HalfYr">
                      <Value>Max No Contractor Labour HalfYr</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Max_No_Contractor_Labour_HalfYr">
                      <Value>=Fields!Max_No_Contractor_Labour_HalfYr.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 8 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Daily_Hours_Of_Work">
                      <Value>Daily Hours Of Work</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Daily_Hours_Of_Work">
                      <Value>=Fields!Daily_Hours_Of_Work.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 9 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Weekly_Holiday">
                      <Value>Weekly Holiday</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Weekly_Holiday">
                      <Value>=Fields!Weekly_Holiday.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 10 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Weekly_Holiday_Paid">
                      <Value>Weekly Holiday Paid</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Weekly_Holiday_Paid">
                      <Value>=Fields!Weekly_Holiday_Paid.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 11 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_No_Of_Mandays_Worked_Men">
                      <Value>No Of Mandays Worked Men</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_No_Of_Mandays_Worked_Men">
                      <Value>=Fields!No_Of_Mandays_Worked_Men.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 12 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_No_Of_Mandays_Worked_Women">
                      <Value>No Of Mandays Worked Women</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_No_Of_Mandays_Worked_Women">
                      <Value>=Fields!No_Of_Mandays_Worked_Women.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 13 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_No_Of_Mandays_Worked_Children">
                      <Value>No Of Mandays Worked Children</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_No_Of_Mandays_Worked_Children">
                      <Value>=Fields!No_Of_Mandays_Worked_Children.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 14 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amount_Of_Wages_Paid_Men">
                      <Value>Amount Of Wages Paid Men</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amount_Of_Wages_Paid_Men">
                      <Value>=Fields!Amount_Of_Wages_Paid_Men.Value</Value>
                      <Style>
                        <Format>N2</Format>
                      </Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 15 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amount_Of_Wages_Paid_Women">
                      <Value>Amount Of Wages Paid Women</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amount_Of_Wages_Paid_Women">
                      <Value>=Fields!Amount_Of_Wages_Paid_Women.Value</Value>
                      <Style><Format>N2</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 16 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amount_Of_Wages_Paid_Children">
                      <Value>Amount Of Wages Paid Children</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amount_Of_Wages_Paid_Children">
                      <Value>=Fields!Amount_Of_Wages_Paid_Children.Value</Value>
                      <Style><Format>N2</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 17 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amt_Of_Deduct_From_Wages_Men">
                      <Value>Amt Of Deduct From Wages Men</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amt_Of_Deduct_From_Wages_Men">
                      <Value>=Fields!Amt_Of_Deduct_From_Wages_Men.Value</Value>
                      <Style><Format>N2</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 18 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amt_Of_Deduct_From_Wages_Women">
                      <Value>Amt Of Deduct From Wages Women</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amt_Of_Deduct_From_Wages_Women">
                      <Value>=Fields!Amt_Of_Deduct_From_Wages_Women.Value</Value>
                      <Style><Format>N2</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 19 -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Amt_Of_Deduct_From_Wages_Children">
                      <Value>Amt Of Deduct From Wages Children</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Amt_Of_Deduct_From_Wages_Children">
                      <Value>=Fields!Amt_Of_Deduct_From_Wages_Children.Value</Value>
                      <Style><Format>N2</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 20 State -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_State">
                      <Value>State</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_State">
                      <Value>=Fields!State.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 21 LabourLicNo -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_LabourLicNo">
                      <Value>Labour Licence No</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_LabourLicNo">
                      <Value>=Fields!LabourLicNo.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 22 CreatedOn -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_CreatedOn">
                      <Value>Created On</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_CreatedOn">
                      <Value>=Fields!CreatedOn.Value</Value>
                      <Style><Format>dd/MM/yyyy</Format></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 23 CreatedBy -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_CreatedBy">
                      <Value>Created By</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_CreatedBy">
                      <Value>=Fields!CreatedBy.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 24 RefNo -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_RefNo">
                      <Value>Ref No</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_RefNo">
                      <Value>=Fields!RefNo.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 25 VCode -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_VCode">
                      <Value>VCode</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_VCode">
                      <Value>=Fields!VCode.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 26 ResubmitedOn -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_ResubmitedOn">
                      <Value>Resubmitted On</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_ResubmitedOn">
                      <Value>=Fields!ResubmitedOn.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 27 Status -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Status">
                      <Value>Status</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Status">
                      <Value>=Fields!Status.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 28 Final_Attachment -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Final_Attachment">
                      <Value>Final Attachment</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Final_Attachment">
                      <Value>=Fields!Final_Attachment.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 29 Welfare_Canteen -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Welfare_Canteen">
                      <Value>Welfare - Canteen</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Welfare_Canteen">
                      <Value>=Fields!Welfare_Canteen.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 30 Welfare_RestRoom -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Welfare_RestRoom">
                      <Value>Welfare - Rest Room</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Welfare_RestRoom">
                      <Value>=Fields!Welfare_RestRoom.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 31 Welfare_DrinkingWater -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Welfare_DrinkingWater">
                      <Value>Welfare - Drinking Water</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Welfare_DrinkingWater">
                      <Value>=Fields!Welfare_DrinkingWater.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 32 Welfare_Creches -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Welfare_Creches">
                      <Value>Welfare - Creches</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Welfare_Creches">
                      <Value>=Fields!Welfare_Creches.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 33 Welfare_FirstAid -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Welfare_FirstAid">
                      <Value>Welfare - First Aid</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Welfare_FirstAid">
                      <Value>=Fields!Welfare_FirstAid.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 34 Year -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Year">
                      <Value>Year</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Year">
                      <Value>=Fields!Year.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 35 Period -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Period">
                      <Value>Period</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Period">
                      <Value>=Fields!Period.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 36 Name_Address_Of_Establishment -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_Name_Address_Of_Establishment">
                      <Value>Name &amp; Address Of Establishment</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_Name_Address_Of_Establishment">
                      <Value>=Fields!Name_Address_Of_Establishment.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 37 sex_M -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_sex_M">
                      <Value>Sex - M</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_sex_M">
                      <Value>=Fields!sex_M.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 38 sex_F -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_sex_F">
                      <Value>Sex - F</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_sex_F">
                      <Value>=Fields!sex_F.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

            <!-- 39 WorkOrderNo -->
            <TablixRow>
              <Height>0.22in</Height>
              <TablixCells>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Label_WorkOrderNo">
                      <Value>Work Order No</Value>
                      <Style><FontWeight>Bold</FontWeight></Style>
                    </Textbox>
                  </CellContents>
                </TablixCell>
                <TablixCell>
                  <CellContents>
                    <Textbox Name="Value_WorkOrderNo">
                      <Value>=Fields!WorkOrderNo.Value</Value>
                    </Textbox>
                  </CellContents>
                </TablixCell>
              </TablixCells>
            </TablixRow>

          </TablixRows>
        </TablixBody>

        <TablixColumnHierarchy>
          <TablixMembers>
            <TablixMember />
            <TablixMember />
          </TablixMembers>
        </TablixColumnHierarchy>

        <TablixRowHierarchy>
          <TablixMembers>
            <!-- A single static member containing all rows -->
            <TablixMember>
              <KeepTogether>true</KeepTogether>
              <TablixMembers>
                <!-- empty - rows are defined in body -->
              </TablixMembers>
            </TablixMember>
          </TablixMembers>
        </TablixRowHierarchy>

        <Top>0.5in</Top>
        <Left>0.2in</Left>
        <Height>8.5in</Height>
        <Width>7.4in</Width>
        <Style>
          <Border>
            <Style>None</Style>
          </Border>
        </Style>
      </Tablix>

    </ReportItems>
    <Height>11in</Height>
  </Body>

  <Width>8.27in</Width>

  <Page>
    <PageHeight>11.69in</PageHeight>
    <PageWidth>8.27in</PageWidth>
    <LeftMargin>0.4in</LeftMargin>
    <RightMargin>0.4in</RightMargin>
    <TopMargin>0.4in</TopMargin>
    <BottomMargin>0.4in</BottomMargin>

    <PageHeader>
      <Height>0.4in</Height>
      <ReportItems>
        <Textbox Name="HeaderCompany">
          <Value>=Globals!ReportName</Value>
          <Top>0.05in</Top>
          <Left>0.2in</Left>
          <Height>0.3in</Height>
          <Width>7.8in</Width>
          <Style>
            <FontSize>10pt</FontSize>
            <TextAlign>Center</TextAlign>
            <FontWeight>Bold</FontWeight>
          </Style>
        </Textbox>
      </ReportItems>
    </PageHeader>

    <PageFooter>
      <Height>0.25in</Height>
      <ReportItems>
        <Textbox Name="FooterText">
          <Value>= &quot;Printed on: &quot; &amp; Format(Globals!ExecutionTime, "dd/MM/yyyy HH:mm")</Value>
          <Top>0.02in</Top>
          <Left>0.2in</Left>
          <Height>0.2in</Height>
          <Width>4in</Width>
          <Style>
            <FontSize>8pt</FontSize>
          </Style>
        </Textbox>

        <Textbox Name="PageNumber">
          <Value>= &quot;Page &quot; &amp; Globals!PageNumber &amp; &quot; of &quot; &amp; Globals!TotalPages</Value>
          <Top>0.02in</Top>
          <Left>6.0in</Left>
          <Height>0.2in</Height>
          <Width>2in</Width>
          <Style>
            <TextAlign>Right</TextAlign>
            <FontSize>8pt</FontSize>
          </Style>
        </Textbox>
      </ReportItems>
    </PageFooter>
  </Page>

  <DataSets>
    <DataSet Name="DataSet1">
      <Fields>
        <!-- Insert all fields exactly as provided -->
        <Field Name="ID"><DataField>ID</DataField></Field>
        <Field Name="Name_Address_Of_Contractor"><DataField>Name_Address_Of_Contractor</DataField></Field>
        <Field Name="Name_and_Address_Of_PrincipalEmp"><DataField>Name_and_Address_Of_PrincipalEmp</DataField></Field>
        <Field Name="Duration_Of_Contract"><DataField>Duration_Of_Contract</DataField></Field>
        <Field Name="Establishment_Of_Principal_Emp_Worked"><DataField>Establishment_Of_Principal_Emp_Worked</DataField></Field>
        <Field Name="Contractors_Establishment_Worked"><DataField>Contractors_Establishment_Worked</DataField></Field>
        <Field Name="Max_No_Contractor_Labour_HalfYr"><DataField>Max_No_Contractor_Labour_HalfYr</DataField></Field>
        <Field Name="Daily_Hours_Of_Work"><DataField>Daily_Hours_Of_Work</DataField></Field>
        <Field Name="Weekly_Holiday"><DataField>Weekly_Holiday</DataField></Field>
        <Field Name="Weekly_Holiday_Paid"><DataField>Weekly_Holiday_Paid</DataField></Field>
        <Field Name="No_Of_Mandays_Worked_Men"><DataField>No_Of_Mandays_Worked_Men</DataField></Field>
        <Field Name="No_Of_Mandays_Worked_Women"><DataField>No_Of_Mandays_Worked_Women</DataField></Field>
        <Field Name="No_Of_Mandays_Worked_Children"><DataField>No_Of_Mandays_Worked_Children</DataField></Field>
        <Field Name="Amount_Of_Wages_Paid_Men"><DataField>Amount_Of_Wages_Paid_Men</DataField></Field>
        <Field Name="Amount_Of_Wages_Paid_Women"><DataField>Amount_Of_Wages_Paid_Women</DataField></Field>
        <Field Name="Amount_Of_Wages_Paid_Children"><DataField>Amount_Of_Wages_Paid_Children</DataField></Field>
        <Field Name="Amt_Of_Deduct_From_Wages_Men"><DataField>Amt_Of_Deduct_From_Wages_Men</DataField></Field>
        <Field Name="Amt_Of_Deduct_From_Wages_Women"><DataField>Amt_Of_Deduct_From_Wages_Women</DataField></Field>
        <Field Name="Amt_Of_Deduct_From_Wages_Children"><DataField>Amt_Of_Deduct_From_Wages_Children</DataField></Field>
        <Field Name="State"><DataField>State</DataField></Field>
        <Field Name="LabourLicNo"><DataField>LabourLicNo</DataField></Field>
        <Field Name="CreatedOn"><DataField>CreatedOn</DataField></Field>
        <Field Name="CreatedBy"><DataField>CreatedBy</DataField></Field>
        <Field Name="RefNo"><DataField>RefNo</DataField></Field>
        <Field Name="VCode"><DataField>VCode</DataField></Field>
        <Field Name="ResubmitedOn"><DataField>ResubmitedOn</DataField></Field>
        <Field Name="Status"><DataField>Status</DataField></Field>
        <Field Name="Final_Attachment"><DataField>Final_Attachment</DataField></Field>
        <Field Name="Welfare_Canteen"><DataField>Welfare_Canteen</DataField></Field>
        <Field Name="Welfare_RestRoom"><DataField>Welfare_RestRoom</DataField></Field>
        <Field Name="Welfare_DrinkingWater"><DataField>Welfare_DrinkingWater</DataField></Field>
        <Field Name="Welfare_Creches"><DataField>Welfare_Creches</DataField></Field>
        <Field Name="Welfare_FirstAid"><DataField>Welfare_FirstAid</DataField></Field>
        <Field Name="Year"><DataField>Year</DataField></Field>
        <Field Name="Period"><DataField>Period</DataField></Field>
        <Field Name="Name_Address_Of_Establishment"><DataField>Name_Address_Of_Establishment</DataField></Field>
        <Field Name="sex_M"><DataField>sex_M</DataField></Field>
        <Field Name="sex_F"><DataField>sex_F</DataField></Field>
        <Field Name="WorkOrderNo"><DataField>WorkOrderNo</DataField></Field>
      </Fields>
      <Query>
        <DataSourceName>DataSet1</DataSourceName>
        <CommandText />
      </Query>
    </DataSet>
  </DataSets>

  <rd:ReportUnitType>Inch</rd:ReportUnitType>
  <rd:ReportID>HalfYearlyLabourReturn-Report</rd:ReportID>
</Report>
