using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddIndividualKeyCheckouts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CheckoutTransactions_Bunches_BunchId",
                table: "CheckoutTransactions");

            migrationBuilder.AddColumn<string>(
                name: "IssuedToName",
                table: "Keys",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "BunchId",
                table: "CheckoutTransactions",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "KeyRecordId",
                table: "CheckoutTransactions",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_CheckoutTransactions_KeyRecordId",
                table: "CheckoutTransactions",
                column: "KeyRecordId");

            migrationBuilder.AddForeignKey(
                name: "FK_CheckoutTransactions_Bunches_BunchId",
                table: "CheckoutTransactions",
                column: "BunchId",
                principalTable: "Bunches",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CheckoutTransactions_Keys_KeyRecordId",
                table: "CheckoutTransactions",
                column: "KeyRecordId",
                principalTable: "Keys",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CheckoutTransactions_Bunches_BunchId",
                table: "CheckoutTransactions");

            migrationBuilder.DropForeignKey(
                name: "FK_CheckoutTransactions_Keys_KeyRecordId",
                table: "CheckoutTransactions");

            migrationBuilder.DropIndex(
                name: "IX_CheckoutTransactions_KeyRecordId",
                table: "CheckoutTransactions");

            migrationBuilder.DropColumn(
                name: "IssuedToName",
                table: "Keys");

            migrationBuilder.DropColumn(
                name: "KeyRecordId",
                table: "CheckoutTransactions");

            migrationBuilder.AlterColumn<int>(
                name: "BunchId",
                table: "CheckoutTransactions",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_CheckoutTransactions_Bunches_BunchId",
                table: "CheckoutTransactions",
                column: "BunchId",
                principalTable: "Bunches",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
