%% function to draw reference $5, add symbol, changed from medical
function drawRef(Data,Win,Img)
H=Win.winrect(4);
W=Win.winrect(3);
if Data.refSide==1 % reference on left
    refDims.x=W/4;
elseif Data.refSide==2 % reference on right
    refDims.x=3*(W/4);
end
refDims.y=H/4;
Screen('TextSize', Win.win, Data.stimulus.fontSize.refValues);
fiveDims = getTextDims(Win.win, '$5', Data.stimulus.fontSize.refValues);
refHeight = Img.imgHeight+fiveDims(2);
refimgRect = [refDims.x-Img.imgWidth/2, refDims.y-refHeight/2, refDims.x+Img.imgWidth/2,refDims.y-refHeight/2+Img.imgWidth];
Screen('DrawTexture',Win.win,Img.fiveTexture,[],refimgRect);
Screen('DrawText', Win.win, '$5',refDims.x-fiveDims(1)/2, refDims.y-refHeight/2+Img.imgWidth, Data.stimulus.fontColor);
end