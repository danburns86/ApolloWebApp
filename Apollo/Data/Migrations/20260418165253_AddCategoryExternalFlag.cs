using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddCategoryExternalFlag : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsExternal",
                table: "ProductionCategories",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AlterColumn<int>(
                name: "RoleId",
                table: "PerformanceCrewOverrides",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<string>(
                name: "CustomRoleName",
                table: "PerformanceCrewOverrides",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_PerformanceCrewOverrides_MemberId",
                table: "PerformanceCrewOverrides",
                column: "MemberId");

            migrationBuilder.CreateIndex(
                name: "IX_PerformanceCrewOverrides_RoleId",
                table: "PerformanceCrewOverrides",
                column: "RoleId");

            migrationBuilder.AddForeignKey(
                name: "FK_PerformanceCrewOverrides_Members_MemberId",
                table: "PerformanceCrewOverrides",
                column: "MemberId",
                principalTable: "Members",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PerformanceCrewOverrides_ProductionRoles_RoleId",
                table: "PerformanceCrewOverrides",
                column: "RoleId",
                principalTable: "ProductionRoles",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PerformanceCrewOverrides_Members_MemberId",
                table: "PerformanceCrewOverrides");

            migrationBuilder.DropForeignKey(
                name: "FK_PerformanceCrewOverrides_ProductionRoles_RoleId",
                table: "PerformanceCrewOverrides");

            migrationBuilder.DropIndex(
                name: "IX_PerformanceCrewOverrides_MemberId",
                table: "PerformanceCrewOverrides");

            migrationBuilder.DropIndex(
                name: "IX_PerformanceCrewOverrides_RoleId",
                table: "PerformanceCrewOverrides");

            migrationBuilder.DropColumn(
                name: "IsExternal",
                table: "ProductionCategories");

            migrationBuilder.DropColumn(
                name: "CustomRoleName",
                table: "PerformanceCrewOverrides");

            migrationBuilder.AlterColumn<int>(
                name: "RoleId",
                table: "PerformanceCrewOverrides",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);
        }
    }
}
