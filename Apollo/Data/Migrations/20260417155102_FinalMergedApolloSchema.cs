using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class FinalMergedApolloSchema : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InspectionRecord_Assets_AssetId",
                table: "InspectionRecord");

            migrationBuilder.DropPrimaryKey(
                name: "PK_InspectionRecord",
                table: "InspectionRecord");

            migrationBuilder.DropColumn(
                name: "LastLOLERDate",
                table: "Assets");

            migrationBuilder.DropColumn(
                name: "LastPATDate",
                table: "Assets");

            migrationBuilder.RenameTable(
                name: "InspectionRecord",
                newName: "InspectionRecords");

            migrationBuilder.RenameIndex(
                name: "IX_InspectionRecord_AssetId",
                table: "InspectionRecords",
                newName: "IX_InspectionRecords_AssetId");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Rooms",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<int>(
                name: "DefaultRisk",
                table: "Rooms",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "ApplianceClass",
                table: "Assets",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "RetestIntervalOverride",
                table: "Assets",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "RiskOverride",
                table: "Assets",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "VisualOnly",
                table: "Assets",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Areas",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddPrimaryKey(
                name: "PK_InspectionRecords",
                table: "InspectionRecords",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_InspectionRecords_Assets_AssetId",
                table: "InspectionRecords",
                column: "AssetId",
                principalTable: "Assets",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InspectionRecords_Assets_AssetId",
                table: "InspectionRecords");

            migrationBuilder.DropPrimaryKey(
                name: "PK_InspectionRecords",
                table: "InspectionRecords");

            migrationBuilder.DropColumn(
                name: "DefaultRisk",
                table: "Rooms");

            migrationBuilder.DropColumn(
                name: "ApplianceClass",
                table: "Assets");

            migrationBuilder.DropColumn(
                name: "RetestIntervalOverride",
                table: "Assets");

            migrationBuilder.DropColumn(
                name: "RiskOverride",
                table: "Assets");

            migrationBuilder.DropColumn(
                name: "VisualOnly",
                table: "Assets");

            migrationBuilder.RenameTable(
                name: "InspectionRecords",
                newName: "InspectionRecord");

            migrationBuilder.RenameIndex(
                name: "IX_InspectionRecords_AssetId",
                table: "InspectionRecord",
                newName: "IX_InspectionRecord_AssetId");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Rooms",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AddColumn<DateTime>(
                name: "LastLOLERDate",
                table: "Assets",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "LastPATDate",
                table: "Assets",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "Areas",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AddPrimaryKey(
                name: "PK_InspectionRecord",
                table: "InspectionRecord",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_InspectionRecord_Assets_AssetId",
                table: "InspectionRecord",
                column: "AssetId",
                principalTable: "Assets",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
