
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2026 21:36:03
// Design Name: 
// Module Name: axi_gpio__slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axi_gpio_slave (

    input wire         clk,
    input wire         reset,

    //------------------------------------------------
    // AXI WRITE ADDRESS CHANNEL
    //------------------------------------------------

    input wire [31:0]  awaddr,
    input wire         awvalid,
    output reg         awready,

    //------------------------------------------------
    // AXI WRITE DATA CHANNEL
    //------------------------------------------------

    input wire [31:0]  wdata,
    input wire         wvalid,
    output reg         wready,

    //------------------------------------------------
    // AXI WRITE RESPONSE CHANNEL
    //------------------------------------------------

    output reg [1:0]   bresp,
    output reg         bvalid,
    input wire         bready,

    //------------------------------------------------
    // AXI READ ADDRESS CHANNEL
    //------------------------------------------------

    input wire [31:0]  araddr,
    input wire         arvalid,
    output reg         arready,

    //------------------------------------------------
    // AXI READ DATA CHANNEL
    //------------------------------------------------

    output reg [31:0]  rdata,
    output reg [1:0]   rresp,
    output reg         rvalid,
    input wire         rready,

    //------------------------------------------------
    // GPIO OUTPUT
    //------------------------------------------------

    output wire [31:0] gpio_out

);

    //------------------------------------------------
    // INTERNAL SIGNALS
    //------------------------------------------------

    wire write_enable;

    //------------------------------------------------
    // WRITE ENABLE LOGIC
    //------------------------------------------------

    assign write_enable = awvalid && wvalid;

    //------------------------------------------------
    // GPIO REGISTER INSTANCE
    //------------------------------------------------

    gpio_register gpio_reg0 (

        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_data(wdata),
        .gpio_out(gpio_out)

    );

    //------------------------------------------------
    // AXI WRITE + READ LOGIC
    //------------------------------------------------

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            //------------------------------------------------
            // WRITE CHANNEL RESET
            //------------------------------------------------

            awready <= 1'b0;
            wready  <= 1'b0;

            bvalid  <= 1'b0;
            bresp   <= 2'b00;

            //------------------------------------------------
            // READ CHANNEL RESET
            //------------------------------------------------

            arready <= 1'b0;

            rvalid  <= 1'b0;
            rresp   <= 2'b00;
            rdata   <= 32'b0;

        end

        else begin

            //------------------------------------------------
            // WRITE ADDRESS + DATA READY
            //------------------------------------------------

            awready <= 1'b1;
            wready  <= 1'b1;

            //------------------------------------------------
            // WRITE RESPONSE
            //------------------------------------------------

            if (awvalid && wvalid) begin

                bvalid <= 1'b1;
                bresp  <= 2'b00; // OKAY response

            end

            //------------------------------------------------
            // COMPLETE WRITE RESPONSE HANDSHAKE
            //------------------------------------------------

            if (bvalid && bready) begin
                bvalid <= 1'b0;
            end

            //------------------------------------------------
            // READ ADDRESS READY
            //------------------------------------------------

            arready <= 1'b1;

            //------------------------------------------------
            // READ TRANSACTION
            //------------------------------------------------

            if (arvalid) begin

                rvalid <= 1'b1;
                rresp  <= 2'b00; // OKAY response

                // Return GPIO register value
                rdata <= gpio_out;

            end

            //------------------------------------------------
            // COMPLETE READ HANDSHAKE
            //------------------------------------------------

            if (rvalid && rready) begin
                rvalid <= 1'b0;
            end

        end
    end

endmodule
