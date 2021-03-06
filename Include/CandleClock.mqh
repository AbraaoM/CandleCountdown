//+------------------------------------------------------------------+
//|                                                  CCandleClock.mqh |
//|                                   Copyright 2021, Abraão Moreira |
//|                                    https://www.abraaomoreira.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Abraão Moreira"
#property link      "https://www.abraaomoreira.com"

#include <MQL5Simplify/Graphic.mqh>

enum clockStyle {
  comment,      //Comment
  bigNumber,    //Big number
  onPrice,      //On Price
};

class CCandleClock {
 private:
  CLabel bigNumberLabel,
         onPriceLabel;
  int onPriceXOffSet,
      onPriceYOffSet;

  string             countdownValue;
  bool bigNumberControl,
       commentControl,
       onPriceControl;

 public:
  CCandleClock :: CCandleClock ();
  CCandleClock ::   ~CCandleClock ();
  string CCandleClock :: GetCountdownValue();

  void CCandleClock :: CountdownUpdate();
  void CCandleClock :: CreateBigNumber (int x = 10,
                                        int y = 2,
                                        string font = "Arial",
                                        int fontSize = 10,
                                        color fontColor = clrBlack,
                                        ENUM_BASE_CORNER corner = CORNER_RIGHT_UPPER,
                                        ENUM_ANCHOR_POINT anchor = ANCHOR_RIGHT_UPPER);
  void CCandleClock :: CreateComment ();

  void CCandleClock :: CreateOnPrice(int offSetX = 0,
                                     int offSetY = 0,
                                     string font = "Arial",
                                     int fontSize = 10,
                                     color fontColor = clrBlack,
                                     ENUM_ANCHOR_POINT anchor = ANCHOR_RIGHT);
};

//+------------------------------------------------------------------+
//|  Constructor                                                     |
//+------------------------------------------------------------------+
CCandleClock :: CCandleClock() {
  bigNumberControl = false;
  commentControl = false;
  onPriceControl = false;
  countdownValue = TimeToString(iTime(_Symbol, PERIOD_CURRENT, 0) +
                                PeriodSeconds() -
                                TimeCurrent(),
                                TIME_SECONDS);
}

//+------------------------------------------------------------------+
//|  Destructor                                                      |
//+------------------------------------------------------------------+
CCandleClock :: ~CCandleClock () {
  bigNumberLabel.Destroy();
  onPriceLabel.Destroy();
  Comment("");
}

//+------------------------------------------------------------------+
//|  Get countdown value                                             |
//+------------------------------------------------------------------+
string CCandleClock :: GetCountdownValue() {
  return countdownValue;
}

//+------------------------------------------------------------------+
//|  Update countdown clock                                          |
//+------------------------------------------------------------------+
void CCandleClock :: CountdownUpdate() {
  countdownValue = TimeToString(iTime(_Symbol, PERIOD_CURRENT, 0) +
                                PeriodSeconds() -
                                TimeCurrent(),
                                TIME_SECONDS);
  if(bigNumberControl)
    bigNumberLabel.ChangeText(countdownValue);
  if(onPriceControl) {
    int x, y;
    datetime time = iTime(_Symbol, PERIOD_CURRENT, 0);
    double close = iClose(_Symbol, PERIOD_CURRENT, 0);
    ChartTimePriceToXY(0, 0, time, close, x, y);
    onPriceLabel.Move(onPriceXOffSet, y + onPriceYOffSet);
    onPriceLabel.ChangeText(countdownValue);
  }
  if(commentControl)
    Comment(countdownValue);
}

//+------------------------------------------------------------------+
//|  Create "big number" display                                     |
//+------------------------------------------------------------------+
void CCandleClock :: CreateBigNumber (int x = 10,
                                      int y = 2,
                                      string font = "Arial",
                                      int fontSize = 10,
                                      color fontColor = clrBlack,
                                      ENUM_BASE_CORNER corner = CORNER_RIGHT_UPPER,
                                      ENUM_ANCHOR_POINT anchor = ANCHOR_RIGHT_UPPER) {
  bigNumberLabel.Create(0,
                        "BigNumber",
                        countdownValue,
                        x,
                        y,
                        font,
                        fontSize,
                        fontColor,
                        anchor,
                        corner);
  bigNumberControl = true;
}

//+------------------------------------------------------------------+
//|  Create "comment" display                                        |
//+------------------------------------------------------------------+
void CCandleClock :: CreateComment() {
  Comment(countdownValue);
  commentControl = true;
}

//+------------------------------------------------------------------+
//|  Create "on price" display                                       |
//+------------------------------------------------------------------+
void CCandleClock :: CreateOnPrice(int offSetX = 0,
                                   int offSetY = 0,
                                   string font = "Arial",
                                   int fontSize = 10,
                                   color fontColor = clrBlack,
                                   ENUM_ANCHOR_POINT anchor = ANCHOR_RIGHT) {
  int x, y;
  datetime time = iTime(_Symbol, PERIOD_CURRENT, 0);
  double close = iClose(_Symbol, PERIOD_CURRENT, 0);
  ChartTimePriceToXY(0, 0, time, close, x, y);
  
  onPriceXOffSet = offSetX;
  onPriceYOffSet = offSetY;
  
  onPriceLabel.Create(0,
                      "OnPrice",
                      countdownValue,
                      offSetX,
                      y + offSetY,
                      font,
                      fontSize,
                      fontColor,
                      anchor,
                      CORNER_RIGHT_UPPER);
  onPriceControl = true;
}

//+------------------------------------------------------------------+
