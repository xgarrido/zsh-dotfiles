{
  gROOT->SetStyle("Plain");

  // Definition of setting style for ROOT histograms
  gStyle->SetTitleTextColor(kBlack);
  gStyle->SetTitleFillColor(kWhite);
  gStyle->SetPalette(kRainBow);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetFrameFillColor(0);
  gStyle->SetPadColor(kWhite);
  gStyle->SetStatColor(kWhite);
  gStyle->SetCanvasColor(kWhite);
  gStyle->SetPadTickX(1);
  gStyle->SetPadTickY(1);
  gStyle->SetTickLength(0.01,"XYZ");
  //  gStyle->SetOptFit(kFALSE);
  gStyle->SetFillColor(10);
  gStyle->SetFillStyle(0);

  // Stat options
  gStyle->SetOptStat("emrou");
  gStyle->SetOptDate(0);
  gStyle->SetDateX(0.1);
  gStyle->SetDateY(0.1);
  gStyle->SetOptFile(0);
  gStyle->SetStatH(0.1);
  gStyle->SetStatW(0.2);
  gStyle->SetOptTitle(0);
  gStyle->SetStatBorderSize(0);
  gStyle->SetStatStyle(0000);   // transparent mode of Stats PaveLabel
  gStyle->SetStatX(0.85);
  gStyle->SetStatY(0.9);

  // // Turn off all borders
  gStyle->SetCanvasBorderMode(0);
  gStyle->SetCanvasBorderSize(0);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetPadBorderMode(0);
  gStyle->SetDrawBorder(0);
  gStyle->SetTitleBorderSize(0);
  gStyle->SetLegendBorderSize(0);
  gStyle->SetLegendFont(42);

  // // Set the size of the default canvas
  gStyle->SetCanvasDefH(500);
  gStyle->SetCanvasDefW(700);
  gStyle->SetCanvasDefX(10);
  gStyle->SetCanvasDefY(10);

  // Set fonts
  gStyle->SetLabelFont(42,"xyz");
  gStyle->SetLabelSize(0.04,"xyz");
  gStyle->SetTitleFont(42,"xyz");
  gStyle->SetTitleFont(42);
  gStyle->SetTitleSize(0.05,"xyz");
  gStyle->SetTextFont(42);
  gStyle->SetStatFont(42);
  gStyle->SetStatFontSize(0.05);
  gStyle->SetTitleX(0.3);
  gStyle->SetTitleW(0.4);
  gStyle->SetStatFormat("6.3f");
  gStyle->SetFitFormat("6.3f");
  gStyle->SetTextAlign(22);
  gStyle->SetTextSize(0.04);

  // Set margins
  gStyle->SetPadTopMargin(0.08);
  gStyle->SetPadBottomMargin(0.12);
  gStyle->SetPadLeftMargin(0.12);
  gStyle->SetPadRightMargin(0.12);

  // Set tick marks and turn off grids
  gStyle->SetNdivisions(510,"xyz");

  gROOT->ForceStyle();
}
