using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddHSFormalReviews : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CoshhAssessments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SubstanceId = table.Column<int>(type: "int", nullable: false),
                    TaskDescription = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RoomId = table.Column<int>(type: "int", nullable: true),
                    ControlMeasures = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PPE_Required = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DisposalInstructions = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AssessmentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ReviewDueDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsApproved = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CoshhAssessments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CoshhAssessments_CoshhSubstances_SubstanceId",
                        column: x => x.SubstanceId,
                        principalTable: "CoshhSubstances",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CoshhAssessments_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "FireRiskAssessmentDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RiskAssessmentId = table.Column<int>(type: "int", nullable: false),
                    Step1_IgnitionSources = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Step1_FuelSources = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Step2_PeopleAtRisk = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Step3_EvaluationNotes = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Step4_RecordPlanTrain = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MaxOccupancy = table.Column<int>(type: "int", nullable: false),
                    FireCurtainTested = table.Column<bool>(type: "bit", nullable: false),
                    ExitRoutesStatus = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FireRiskAssessmentDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FireRiskAssessmentDetails_RiskAssessments_RiskAssessmentId",
                        column: x => x.RiskAssessmentId,
                        principalTable: "RiskAssessments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RiskAssessmentReviews",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RiskAssessmentId = table.Column<int>(type: "int", nullable: false),
                    ReviewDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ReviewedBy = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ReviewOutcome = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Comments = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    NextReviewDueDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RiskAssessmentReviews", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RiskAssessmentReviews_RiskAssessments_RiskAssessmentId",
                        column: x => x.RiskAssessmentId,
                        principalTable: "RiskAssessments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CoshhAssessments_RoomId",
                table: "CoshhAssessments",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_CoshhAssessments_SubstanceId",
                table: "CoshhAssessments",
                column: "SubstanceId");

            migrationBuilder.CreateIndex(
                name: "IX_FireRiskAssessmentDetails_RiskAssessmentId",
                table: "FireRiskAssessmentDetails",
                column: "RiskAssessmentId");

            migrationBuilder.CreateIndex(
                name: "IX_RiskAssessmentReviews_RiskAssessmentId",
                table: "RiskAssessmentReviews",
                column: "RiskAssessmentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CoshhAssessments");

            migrationBuilder.DropTable(
                name: "FireRiskAssessmentDetails");

            migrationBuilder.DropTable(
                name: "RiskAssessmentReviews");
        }
    }
}
