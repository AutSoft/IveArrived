using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace IveArrived.Migrations
{
    public partial class CourierServiceToCourier : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Password",
                table: "AspNetUsers");

            migrationBuilder.AlterColumn<string>(
                name: "PackageId",
                table: "Delivery",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AddColumn<int>(
                name: "CourierTokenId",
                table: "Delivery",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PaymentInfo",
                table: "Delivery",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "CourierServiceToCourier",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CourierServiceId = table.Column<int>(nullable: true),
                    CourierId = table.Column<int>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CourierServiceToCourier", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CourierServiceToCourier_AspNetUsers_CourierId",
                        column: x => x.CourierId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_CourierServiceToCourier_AspNetUsers_CourierServiceId",
                        column: x => x.CourierServiceId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Delivery_CourierTokenId",
                table: "Delivery",
                column: "CourierTokenId");

            migrationBuilder.CreateIndex(
                name: "IX_CourierServiceToCourier_CourierId",
                table: "CourierServiceToCourier",
                column: "CourierId");

            migrationBuilder.CreateIndex(
                name: "IX_CourierServiceToCourier_CourierServiceId",
                table: "CourierServiceToCourier",
                column: "CourierServiceId");

            migrationBuilder.AddForeignKey(
                name: "FK_Delivery_FcmToken_CourierTokenId",
                table: "Delivery",
                column: "CourierTokenId",
                principalTable: "FcmToken",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Delivery_FcmToken_CourierTokenId",
                table: "Delivery");

            migrationBuilder.DropTable(
                name: "CourierServiceToCourier");

            migrationBuilder.DropIndex(
                name: "IX_Delivery_CourierTokenId",
                table: "Delivery");

            migrationBuilder.DropColumn(
                name: "CourierTokenId",
                table: "Delivery");

            migrationBuilder.DropColumn(
                name: "PaymentInfo",
                table: "Delivery");

            migrationBuilder.AlterColumn<Guid>(
                name: "PackageId",
                table: "Delivery",
                type: "uniqueidentifier",
                nullable: false,
                oldClrType: typeof(string),
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
