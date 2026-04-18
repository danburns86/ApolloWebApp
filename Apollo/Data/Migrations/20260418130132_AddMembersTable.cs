using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddMembersTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Members",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MemberNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MobileNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MembershipStatus = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ExpiryDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IsFirstAider = table.Column<bool>(type: "bit", nullable: false),
                    HasDBS = table.Column<bool>(type: "bit", nullable: false),
                    IsTechTeam = table.Column<bool>(type: "bit", nullable: false),
                    SkillActing = table.Column<bool>(type: "bit", nullable: false),
                    SkillDirector = table.Column<bool>(type: "bit", nullable: false),
                    SkillLXDesign = table.Column<bool>(type: "bit", nullable: false),
                    SkillLXOp = table.Column<bool>(type: "bit", nullable: false),
                    SkillSoundDesign = table.Column<bool>(type: "bit", nullable: false),
                    SkillSoundOp = table.Column<bool>(type: "bit", nullable: false),
                    SkillStageManager = table.Column<bool>(type: "bit", nullable: false),
                    SkillStageCrew = table.Column<bool>(type: "bit", nullable: false),
                    SkillWardrobe = table.Column<bool>(type: "bit", nullable: false),
                    SkillSetBuild = table.Column<bool>(type: "bit", nullable: false),
                    SkillFOH = table.Column<bool>(type: "bit", nullable: false),
                    SkillBar = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Members", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Members");
        }
    }
}
