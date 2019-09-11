%% function to draw reference "slight improvement"
function drawRefmed(Data,Win,Img)
H=Win.winrect(4);
W=Win.winrect(3);
if Data.refSide==1 % reference on left
    refDims.x=W/4;
elseif Data.refSide==2 % reference on right
    refDims.x=3*(W/4);
end
refDims.y=H/4;
Screen('TextSize', Win.win, Data.stimulus.fontSize.refValues);
slightDims = getTextDims(Win.win, 'slight', Data.stimulus.fontSize.refValues);
improvDims = getTextDims(Win.win, 'improvement', Data.stimulus.fontSize.refValues);
refHeight = Img.imgHeight+slightDims(2)+improvDims(2);
refimgRect = [refDims.x-Img.imgWidth/2, refDims.y-refHeight/2, refDims.x+Img.imgWidth/2,refDims.y-refHeight/2+Img.imgWidth];
Screen('DrawTexture',Win.win,Img.slTexture,[],refimgRect);
Screen('DrawText', Win.win, 'slight',refDims.x-slightDims(1)/2, refDims.y-refHeight/2+Img.imgWidth, Data.stimulus.fontColor);
Screen('DrawText', Win.win, 'improvement',refDims.x-improvDims(1)/2, refDims.y-refHeight/2+Img.imgWidth+slightDims(2), Data.stimulus.fontColor);
end