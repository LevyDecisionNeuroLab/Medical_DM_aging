%% function to set text and rectangle parameters
function params = setParams_LSRA; 
params.fontName='Ariel';
params.fontColor=[255 255 255]; % white

% font of probability inside the rectangle
params.fontSize.probabilities=20;
% params.textDims.probabilities=[31 30];
% params.fontSize.refProbabilities=10;
% params.textDims.refProbabilities=[12 19];

params.fontSize.pause=38;

% font of lottery values
% textDims, [width height]
params.fontSize.lotteryValues=36;
% params.textDims.lotteryValues.Digit1=[64 64];
% params.textDims.lotteryValues.Digit2=[92 64];
% params.textDims.lotteryValues.Digit3=[120 64];

%font of reference
params.fontSize.refValues=36;
% params.textDims.refValues.Digit1=[31 30];
% params.textDims.refValues.Digit2=[42 30];

% rectangle size
params.lotto.width=150;
params.lotto.height=300;
% params.ref.width=50;
% params.ref.height=100;
params.occ.width=170;
end