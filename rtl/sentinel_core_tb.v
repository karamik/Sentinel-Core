`timescale 1ns / 1ps

module sentinel_core_tb;

    // Параметры симуляции
    reg clk;
    reg rst_n;
    reg [3:0] thermal_sense;
    reg mesh_status;
    reg [255:0] data_in;
    
    wire [255:0] data_out;
    wire [1:0] security_state;
    wire tamper_alarm;

    // Подключаем наш основной модуль (Device Under Test)
    sentinel_core_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .thermal_sense(thermal_sense),
        .mesh_status(mesh_status),
        .data_in(data_in),
        .data_out(data_out),
        .security_state(security_state),
        .tamper_alarm(tamper_alarm)
    );

    // Генерация тактовой частоты 100 MHz (период 10нс)
    always #5 clk = ~clk;

    initial begin
        // --- Шаг 1: Инициализация системы ---
        clk = 0;
        rst_n = 0;
        thermal_sense = 4'b0000;
        mesh_status = 1; // Все системы в норме
        data_in = 256'hDEADBEEF_CAFE_BABE_1234_5678_90AB_CDEF;
        
        #20 rst_n = 1; // Сброс снят
        $display("[%0t ns] System Online. State: %b", $time, security_state);

        // --- Шаг 2: Имитация лазерной атаки (Thermal Anomaly) ---
        #100;
        $display("[%0t ns] ALERT: Simulating Laser Injection on Sector 2...", $time);
        thermal_sense = 4'b0100; // Локальный перегрев обнаружен!
        
        // Замеряем время реакции
        wait(security_state == 2'b01); 
        $display("[%0t ns] SUCCESS: Logic Migration Triggered! Reaction time measured.", $time);
        
        // --- Шаг 3: Имитация физического взлома корпуса (Mesh Breach) ---
        #500;
        $display("[%0t ns] CRITICAL: Physical Mesh Breach Detected!", $time);
        mesh_status = 0; // Сетка разорвана буром/фрезой
        
        wait(security_state == 2'b11);
        $display("[%0t ns] FINAL: SCORCHED EARTH PROTOCOL ACTIVE. System Bricked.", $time);
        
        #100 $finish;
    end

endmodule
