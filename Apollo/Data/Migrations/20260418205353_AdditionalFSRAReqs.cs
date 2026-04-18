using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AdditionalFSRAReqs : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ConstructionDetails",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "RiskAssessments",
                type: "nvarchar(21)",
                maxLength: 21,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "MaxOccupancy",
                table: "RiskAssessments",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Narrative_EvaluationNotes",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Narrative_HazardsFound",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Narrative_PeopleAtRisk",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "NumberOfFloors",
                table: "RiskAssessments",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Arson_Secure",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Arson_WasteSafe",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Contractors_Qualified",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Cook_Safe",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Elec_ApplianceTested",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Elec_FixedInspected",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Elec_NoAdapters",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Escape_ExitsOpenable",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Escape_Obstructions",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Heat_Maintenance",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Housekeeping_Clear",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Manage_Training",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Smoke_MeasuresInPlace",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Smoke_SignageProvided",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Warning_AlarmSuitable",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Q_Warning_DetectorsAdequate",
                table: "RiskAssessments",
                type: "bit",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "UseOfPremises",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "FireActionPlanItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FireRiskAssessmentId = table.Column<int>(type: "int", nullable: false),
                    ItemName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Deficiency = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ProposedAction = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Timescale = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PersonResponsible = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsCompleted = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FireActionPlanItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FireActionPlanItems_RiskAssessments_FireRiskAssessmentId",
                        column: x => x.FireRiskAssessmentId,
                        principalTable: "RiskAssessments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RoomFireSafetyAssignments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FireRiskAssessmentId = table.Column<int>(type: "int", nullable: false),
                    RoomId = table.Column<int>(type: "int", nullable: false),
                    IsCoveredByAreaAssessment = table.Column<bool>(type: "bit", nullable: false),
                    ExceptionNote = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RoomFireSafetyAssignments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RoomFireSafetyAssignments_RiskAssessments_FireRiskAssessmentId",
                        column: x => x.FireRiskAssessmentId,
                        principalTable: "RiskAssessments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RoomFireSafetyAssignments_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FireActionPlanItems_FireRiskAssessmentId",
                table: "FireActionPlanItems",
                column: "FireRiskAssessmentId");

            migrationBuilder.CreateIndex(
                name: "IX_RoomFireSafetyAssignments_FireRiskAssessmentId",
                table: "RoomFireSafetyAssignments",
                column: "FireRiskAssessmentId");

            migrationBuilder.CreateIndex(
                name: "IX_RoomFireSafetyAssignments_RoomId",
                table: "RoomFireSafetyAssignments",
                column: "RoomId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FireActionPlanItems");

            migrationBuilder.DropTable(
                name: "RoomFireSafetyAssignments");

            migrationBuilder.DropColumn(
                name: "ConstructionDetails",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "MaxOccupancy",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Narrative_EvaluationNotes",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Narrative_HazardsFound",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Narrative_PeopleAtRisk",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "NumberOfFloors",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Arson_Secure",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Arson_WasteSafe",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Contractors_Qualified",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Cook_Safe",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Elec_ApplianceTested",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Elec_FixedInspected",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Elec_NoAdapters",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Escape_ExitsOpenable",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Escape_Obstructions",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Heat_Maintenance",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Housekeeping_Clear",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Manage_Training",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Smoke_MeasuresInPlace",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Smoke_SignageProvided",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Warning_AlarmSuitable",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "Q_Warning_DetectorsAdequate",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "UseOfPremises",
                table: "RiskAssessments");
        }
    }
}
