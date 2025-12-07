module sevenseg_decoder (
  parameter bit ACTIVE_LOW = 1   
) (
  input  logic [3:0] d,          
  output logic [6:0] seg        
);
  logic [6:0] hi;
  always_comb unique case (d)
    4'd0: hi=7'b1111110; 4'd1: hi=7'b0110000; 4'd2: hi=7'b1101101; 4'd3: hi=7'b1111001;
    4'd4: hi=7'b0110011; 4'd5: hi=7'b1011011; 4'd6: hi=7'b1011111; 4'd7: hi=7'b1110000;
    4'd8: hi=7'b1111111; 4'd9: hi=7'b1111011; default: hi=7'b0000001; 
  endcase
  assign seg = ACTIVE_LOW ? ~hi : hi;
endmodule

module pulse_div #(parameter int FCLK=100_000_000, parameter int HZ=1)(
  input  logic clk, rst_n,
  output logic tick
);
  localparam int N = (FCLK/HZ) - 1;
  int c;
  always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin c<=0; tick<=0; end
    else begin
      tick <= (c==N);
      c    <= (c==N) ? 0 : c+1;
    end
  end
endmodule

module walk_timer #(
  parameter int WALK_SECS = 10
) (
  input  logic clk, rst_n, tick_1hz, tick_flash,
  input  logic walk_start,            
  output logic walk_active, walk_done, 
  output logic walk_led,               
  output logic [6:0] secs              
);
  typedef enum logic {IDLE,RUN} st_t; st_t st;
  logic [6:0] rem; logic led_q;

  always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin st<=IDLE; rem<=0; walk_done<=0; led_q<=0; end
    else begin
      walk_done <= 0;
      case(st)
        IDLE: if(walk_start) begin st<=RUN; rem<=WALK_SECS; led_q<=0; end
        RUN:  if(tick_1hz) begin
                if(rem==0) begin st<=IDLE; walk_done<=1; end
                else rem <= rem-1;
              end
      endcase
      if(st==RUN && tick_flash) led_q <= ~led_q;
      if(st==IDLE) led_q <= 0;
    end
  end
  assign walk_active = (st==RUN);
  assign walk_led    = led_q;
  assign secs        = rem;
endmodule

module sevenseg2 #(
  parameter bit SEG_ACTIVE_LOW = 1,        
  parameter bit AN_ACTIVE_LOW  = 1         
) (
  input  logic clk, rst_n, tick_mux,
  input  logic [3:0] ones, tens,
  output logic [6:0] seg,
  output logic [3:0] an                    
);
  logic sel; 
  always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) sel<=0; else if(tick_mux) sel<=~sel;
  end

  sevenseg_decoder #(.ACTIVE_LOW(SEG_ACTIVE_LOW)) dec(
    .d(sel ? tens : ones), .seg(seg)
  );

  always_comb begin
    logic [3:0] hi = sel ? 4'b0010 : 4'b0001;      
    an = AN_ACTIVE_LOW ? ~hi : hi;
  end
endmodule

module ped_walk_display #(
  parameter int FCLK_HZ       = 100_000_000, 
  parameter int WALK_SECS     = 10,         
  parameter int MUX_HZ        = 1000,        
  parameter int FLASH_HZ      = 2,          
  parameter bit SEG_ACTIVE_LOW= 1,        
  parameter bit AN_ACTIVE_LOW = 1          
) (
  input  logic clk, rst_n,
  input  logic walk_start,       
  output logic walk_done,        
  output logic walk_led,          
  output logic [6:0] seg,
  output logic [3:0] an
);
  logic t1hz, tmux, tflash;
  pulse_div #(.FCLK(FCLK_HZ), .HZ(1        )) div1 (.clk(clk), .rst_n(rst_n), .tick(t1hz));
  pulse_div #(.FCLK(FCLK_HZ), .HZ(MUX_HZ   )) divm (.clk(clk), .rst_n(rst_n), .tick(tmux));
  pulse_div #(.FCLK(FCLK_HZ), .HZ(2*FLASH_HZ)) divf (.clk(clk), .rst_n(rst_n), .tick(tflash));

  logic active; logic [6:0] secs;
  walk_timer #(.WALK_SECS(WALK_SECS)) wt(
    .clk(clk), .rst_n(rst_n), .tick_1hz(t1hz), .tick_flash(tflash),
    .walk_start(walk_start), .walk_active(active), .walk_done(walk_done),
    .walk_led(walk_led), .secs(secs)
  );

  logic [3:0] ones = secs % 10;
  logic [3:0] tens = (secs/10) % 10;

  sevenseg2 #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW), .AN_ACTIVE_LOW(AN_ACTIVE_LOW)) disp(
    .clk(clk), .rst_n(rst_n), .tick_mux(tmux),
    .ones(ones), .tens(tens), .seg(seg), .an(an)
  );
endmodule

