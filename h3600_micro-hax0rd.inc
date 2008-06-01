
subgraph cluster_CPU_IRQ {
  label = "CPU_IRQ Handler";
  style = filled;
  color = lightgrey;
  Label123;
  Label125;
  Label126;
  Label127;
  Label124;
  Label128 [
    label = "Label128 | r23, bit 4"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label129;
  Label130 [
    label = "Label130 | r23, bit 1"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label131;
  Label132 [
    label = "Label132 | r23, bit 2"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label133;
  Label134 [
    label = "Label134 | r23, bit 3"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label135;
  Label136;
  Label137;
  Label137 [
    label = "Label137 | r22, bit 7"
    shape = "record"
    style = filled
    color = "lightblue2"
  ];
  Label138;
  Label139;
  Label139 [
    label = "Label139 | r23, bit 6"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label140;
  Label141;
  Label142;
  Label143;
  Label143 [
    label = "Label143 | r23, bit 7"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label144;
  Label145;
  Label146;
  Label147;
  Label148;
  Label149;
  Label150;
  Label151;
  Label151 [
    label = "Label151 | r23, bit 5"
    shape = "record"
    style = filled
    color = "palegreen2"
  ];
  Label152;
  Label153;
  Label154;
  Label155;
  Label156;
  Label157;
  Label158;
  Function2;
  Function3;
  Function4;
  Label291;
  Label292;
  Label293;
  Label294;
  Label295;
}


subgraph cluster_adc {
  label = "ADC cruft";
  style = filled;
  color = sandybrown;

  Label159;
  Label160;
  Label161;
  Label162;
  Label163;
  Label164;
  Label165;
  Label166;
  Label167;
  Label168;
  Label169;
  Label290;
  Function1;
}

subgraph cluster_notif_led {
  label = "Notfication LED";
  style = filled;
  color = seagreen1;

  Label170;
  Label171;
  Label172;
  Label173;
  Label174;
  Label175;
  Label176;
  Label177;
}

subgraph cluster_r9 {
  label = "r9 Handler (does what??)"
  style = filled;
  color = plum1;

  Label214 [
    label = "Label214 | r9, bit 0"
    shape = "record"
  ];
  Label215;
  Label216;
  Label217;
  Label218;
  Label219;
  Label220;
  Label221;
  Label222;
  Label223;
  Label224;
  Label225;
  Label226;
  Label227;
  Label228;
  Label229;
  Label230;
  Label231;
  Label232;
  Label233;
  Label234;
  Label235;
  Label236;
  Label237;
  Label238;
  Label239;
  Label240;
}

subgraph cluster_message_handler {
  label = "UART message handler"
  style = filled;
  color = gold;

  RX_Handler_MSG_NOTIFY_LED
  RX_Handler_DEMUX
  RX_Handler_MSG_EEPROM_READ
  RX_Handler_MSG_EEPROM_WRITE
  RX_Handler_MSG_BATTERY
  RX_Handler_MSG_BACKLIGHT
  RX_Handler_MSG_SPI_READ
  RX_Handler_MSG_SPI_WRITE
  RX_Handler_MSG_THERMAL_SENSOR
  RX_Handler_DEMUX_Out
  RX_Handler_MSG_VERSION
  Label276;
  Label277;
  Label278;
  Label279;
  Label280;
  Label281;
  Label282;
  Label283;
  Label284;
  Label296;
  Label297;
  Label298;
  Label299;
  Label300;
  Label301;
  Label302;
  Label303;
  Label304;
  Label305;
  Label306;
  Label307;
  Label308;
  Label309;
  Label313;
  Label314;
  Label315;
  Label316;
  Label317;
  Label318;
  Label319;
  Label320;
  Function5;
  Function6;
}

subgraph cluster_spi {
  label = "SPI action handler"
  style = filled;
  color = crimson;

  Label241;
  Label242;
  Label243;
  Label244;
  Label245;
  Label246;
  Label247;
  Label248;
  Label249;
  Label250;
  Label251;
  Label252;
  Label253;
  Label254;
  Label255;
  Label256;
  Label257;
  Label258;
  Label259;
  Label260;
  Label261;
  Label262;
  Label263;
  Label264;
  Label265;
  Label266;
  Label267;
  Label268;
  Label269;
  Label270;
  Label271;
  Label272;
  Label273;
  Label274;
}

subgraph cluster_charging_logic {
  label = "Charging Logic"
  style = filled;
  color = maroon1;

  /* possibly some left to charge calculation */
  Function13;
  Label310;
  Label311;
  Label312;

  Label178;
  Label179;
  Label180;
  Label181;
  Label182;
  Label183;
  Label184;
  Label185;
  Label186;
  Label187;
  Label188;
  Label189;
  Label190;
  Label191;
  Label192;
  Label193;
  Label194;
  Label195;
  Label196;
  Label197;
  Label198;
  Label199;
  Label200;
  Label201;
  Label202;
  Label203;
  Label204;
  Label205;
  Label206;
  Label207;
  Label208;
  Label209;
  Label210;
  Label211;
  Label212;
  Label213;

}

subgraph cluster_startup {
  label = "Initialization"
  style = filled;
  color = yellowgreen;

  __vect_Reset
  _on_other_reset
  _on_power_on_reset
  Label120
  Label121
}
