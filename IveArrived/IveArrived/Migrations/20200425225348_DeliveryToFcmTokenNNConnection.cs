using Microsoft.EntityFrameworkCore.Migrations;

namespace IveArrived.Migrations
{
    public partial class DeliveryToFcmTokenNNConnection : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FcmToken_Delivery_DeliveryId",
                table: "FcmToken");

            migrationBuilder.DropIndex(
                name: "IX_FcmToken_DeliveryId",
                table: "FcmToken");

            migrationBuilder.DropColumn(
                name: "DeliveryId",
                table: "FcmToken");

            migrationBuilder.CreateTable(
                name: "FcmTokenToDelivery",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TokenId = table.Column<int>(nullable: true),
                    DeliveryId = table.Column<int>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FcmTokenToDelivery", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FcmTokenToDelivery_Delivery_DeliveryId",
                        column: x => x.DeliveryId,
                        principalTable: "Delivery",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_FcmTokenToDelivery_FcmToken_TokenId",
                        column: x => x.TokenId,
                        principalTable: "FcmToken",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FcmTokenToDelivery_DeliveryId",
                table: "FcmTokenToDelivery",
                column: "DeliveryId");

            migrationBuilder.CreateIndex(
                name: "IX_FcmTokenToDelivery_TokenId",
                table: "FcmTokenToDelivery",
                column: "TokenId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FcmTokenToDelivery");

            migrationBuilder.AddColumn<int>(
                name: "DeliveryId",
                table: "FcmToken",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_FcmToken_DeliveryId",
                table: "FcmToken",
                column: "DeliveryId");

            migrationBuilder.AddForeignKey(
                name: "FK_FcmToken_Delivery_DeliveryId",
                table: "FcmToken",
                column: "DeliveryId",
                principalTable: "Delivery",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
