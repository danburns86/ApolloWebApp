using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddContentWarningsAndUnavailability : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CustomContentWarnings",
                table: "Productions",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "WarnAdultLanguageLevel",
                table: "Productions",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<bool>(
                name: "WarnAudienceInteraction",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnDistressingThemes",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnFlashingLights",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnGunshotsPyros",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnLoudNoises",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnSexualContent",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnSmokeHaze",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnStageSmoking",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "WarnViolenceGore",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "ScriptNumber",
                table: "ProductionCrews",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ScriptNumber",
                table: "ProductionCasts",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsTemporaryPlaceholder",
                table: "Members",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CustomContentWarnings",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnAdultLanguageLevel",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnAudienceInteraction",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnDistressingThemes",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnFlashingLights",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnGunshotsPyros",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnLoudNoises",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnSexualContent",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnSmokeHaze",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnStageSmoking",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "WarnViolenceGore",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "ScriptNumber",
                table: "ProductionCrews");

            migrationBuilder.DropColumn(
                name: "ScriptNumber",
                table: "ProductionCasts");

            migrationBuilder.DropColumn(
                name: "IsTemporaryPlaceholder",
                table: "Members");
        }
    }
}
