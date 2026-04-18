using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddLocationsAndDepartments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ResponsibleUserId",
                table: "Bunches");

            migrationBuilder.AddColumn<int>(
                name: "StorageLocationId",
                table: "Keys",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "IssuedToName",
                table: "Bunches",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100,
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DepartmentId",
                table: "Bunches",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "StorageLocationId",
                table: "Bunches",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Departments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Departments", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "StorageLocations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StorageLocations", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Keys_StorageLocationId",
                table: "Keys",
                column: "StorageLocationId");

            migrationBuilder.CreateIndex(
                name: "IX_Bunches_DepartmentId",
                table: "Bunches",
                column: "DepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Bunches_StorageLocationId",
                table: "Bunches",
                column: "StorageLocationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Bunches_Departments_DepartmentId",
                table: "Bunches",
                column: "DepartmentId",
                principalTable: "Departments",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Bunches_StorageLocations_StorageLocationId",
                table: "Bunches",
                column: "StorageLocationId",
                principalTable: "StorageLocations",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Keys_StorageLocations_StorageLocationId",
                table: "Keys",
                column: "StorageLocationId",
                principalTable: "StorageLocations",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bunches_Departments_DepartmentId",
                table: "Bunches");

            migrationBuilder.DropForeignKey(
                name: "FK_Bunches_StorageLocations_StorageLocationId",
                table: "Bunches");

            migrationBuilder.DropForeignKey(
                name: "FK_Keys_StorageLocations_StorageLocationId",
                table: "Keys");

            migrationBuilder.DropTable(
                name: "Departments");

            migrationBuilder.DropTable(
                name: "StorageLocations");

            migrationBuilder.DropIndex(
                name: "IX_Keys_StorageLocationId",
                table: "Keys");

            migrationBuilder.DropIndex(
                name: "IX_Bunches_DepartmentId",
                table: "Bunches");

            migrationBuilder.DropIndex(
                name: "IX_Bunches_StorageLocationId",
                table: "Bunches");

            migrationBuilder.DropColumn(
                name: "StorageLocationId",
                table: "Keys");

            migrationBuilder.DropColumn(
                name: "DepartmentId",
                table: "Bunches");

            migrationBuilder.DropColumn(
                name: "StorageLocationId",
                table: "Bunches");

            migrationBuilder.AlterColumn<string>(
                name: "IssuedToName",
                table: "Bunches",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ResponsibleUserId",
                table: "Bunches",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
