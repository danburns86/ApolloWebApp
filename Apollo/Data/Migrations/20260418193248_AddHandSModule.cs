using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddHandSModule : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CoshhSubstances",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Manufacturer = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MsdsFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MsdsExpiry = table.Column<DateTime>(type: "datetime2", nullable: true),
                    HazardPictograms = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UseInstructions = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CoshhSubstances", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "FireSystemComponents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UniqueID = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Type = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsMaintained = table.Column<bool>(type: "bit", nullable: false),
                    RoomId = table.Column<int>(type: "int", nullable: false),
                    SpecificLocation = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LastTested = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsActive = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FireSystemComponents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FireSystemComponents_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "IncidentRecords",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Timestamp = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Severity = table.Column<int>(type: "int", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PersonsInvolved = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TreatmentGiven = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RoomId = table.Column<int>(type: "int", nullable: true),
                    IsRiddorReportable = table.Column<bool>(type: "bit", nullable: false),
                    RiddorReportedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_IncidentRecords", x => x.Id);
                    table.ForeignKey(
                        name: "FK_IncidentRecords_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "RiskAssessments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Type = table.Column<int>(type: "int", nullable: false),
                    ProductionId = table.Column<int>(type: "int", nullable: true),
                    AreaId = table.Column<int>(type: "int", nullable: true),
                    AssessedBy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AssessmentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ReviewDueDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsApproved = table.Column<bool>(type: "bit", nullable: false),
                    ApprovedBy = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RiskAssessments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RiskAssessments_Areas_AreaId",
                        column: x => x.AreaId,
                        principalTable: "Areas",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_RiskAssessments_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "RAHazards",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RiskAssessmentId = table.Column<int>(type: "int", nullable: false),
                    HazardName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    WhoIsAtRisk = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    InitialLikelihood = table.Column<int>(type: "int", nullable: false),
                    InitialSeverity = table.Column<int>(type: "int", nullable: false),
                    MitigationMeasures = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ResidualLikelihood = table.Column<int>(type: "int", nullable: false),
                    ResidualSeverity = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RAHazards", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RAHazards_RiskAssessments_RiskAssessmentId",
                        column: x => x.RiskAssessmentId,
                        principalTable: "RiskAssessments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FireSystemComponents_RoomId",
                table: "FireSystemComponents",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_IncidentRecords_RoomId",
                table: "IncidentRecords",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_RAHazards_RiskAssessmentId",
                table: "RAHazards",
                column: "RiskAssessmentId");

            migrationBuilder.CreateIndex(
                name: "IX_RiskAssessments_AreaId",
                table: "RiskAssessments",
                column: "AreaId");

            migrationBuilder.CreateIndex(
                name: "IX_RiskAssessments_ProductionId",
                table: "RiskAssessments",
                column: "ProductionId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CoshhSubstances");

            migrationBuilder.DropTable(
                name: "FireSystemComponents");

            migrationBuilder.DropTable(
                name: "IncidentRecords");

            migrationBuilder.DropTable(
                name: "RAHazards");

            migrationBuilder.DropTable(
                name: "RiskAssessments");
        }
    }
}
