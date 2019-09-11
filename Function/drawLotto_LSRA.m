%% Draw monetary lottery, add a graphic, change from medical
function Data=drawLotto_LSRA(Data,trial,Win,Img);
% Data struct specifies the 
% Trial specifies prob, val, ambig
% Probability for each color
if strcmp(Data.colorKey{Data.colors(trial)},'blue')
    redProb=1-Data.probs(trial);
    blueProb=Data.probs(trial);
elseif strcmp(Data.colorKey{Data.colors(trial)},'red')
    redProb=Data.probs(trial);
    blueProb=1-Data.probs(trial);
end

H=Win.winrect(4); % Height
W=Win.winrect(3); % Width
Y1=(H-Data.stimulus.lotto.height)/2; % Top of lottery
Y2=Y1+Data.stimulus.lotto.height*redProb; % bottom of red bar
Y3=Y2+Data.stimulus.lotto.height*blueProb; % bottom of blue bar

Y2occ=Y1+Data.stimulus.lotto.height*((1-Data.ambigs(trial))/2); % top of occluder
Y3occ=Y2occ+Data.stimulus.lotto.height*((Data.ambigs(trial))); % bottom of occluder

Screen(Win.win, 'FillRect', 1  ); % what does 1 mean here??????????????????????????
lottoRedDims=[W/2-Data.stimulus.lotto.width/2, Y1, W/2+Data.stimulus.lotto.width/2, Y2]; % dimension of red bar
Screen(Win.win,'FillRect',[255 0 0],lottoRedDims);
lottoBlueDims=[W/2-Data.stimulus.lotto.width/2, Y2, W/2+Data.stimulus.lotto.width/2, Y3];
Screen(Win.win,'FillRect',[0 0 255],lottoBlueDims);
lottoAmbigDims=[W/2-Data.stimulus.occ.width/2, Y2occ, W/2+Data.stimulus.occ.width/2, Y3occ];
Screen(Win.win,'FillRect',[127 127 127],lottoAmbigDims);

% specify medical improvement level
if Data.vals(trial) == 5
    monlevel = '$5';
    imgTexture = Img.fiveTexture;
elseif Data.vals(trial) == 8
    monlevel = '$8';
    imgTexture = Img.eightTexture;
elseif Data.vals(trial) == 12
    monlevel = '$12';
    imgTexture = Img.twelveTexture;
elseif Data.vals(trial) == 25
    monlevel = '$25';
    imgTexture = Img.twofiveTexture;
end

% Wirite text of value and probability
if strcmp(Data.colorKey{Data.colors(trial)},'blue') % blue trial, down
    Screen('TextSize', Win.win, Data.stimulus.fontSize.lotteryValues);
    monlevelDims = getTextDims(Win.win,monlevel,Data.stimulus.fontSize.lotteryValues);
    Screen('DrawText', Win.win, monlevel,W/2-monlevelDims(1)/2, Y3+10, Data.stimulus.fontColor); 
    Screen('DrawTexture',Win.win,imgTexture,[],[W/2-Img.imgWidth/2,Y3+10+monlevelDims(2),W/2+Img.imgWidth/2,Y3+10+monlevelDims(2)+Img.imgHeight])
    
    nulllevelDims = getTextDims(Win.win,'$0',Data.stimulus.fontSize.lotteryValues);
    Screen('DrawText',Win.win, '$0', W/2-nulllevelDims(1)/2, Y1-10-nulllevelDims(2), Data.stimulus.fontColor); % $0
    Screen('DrawTexture',Win.win,Img.zeroTexture,[],[W/2-Img.imgWidth/2,Y1-10-nulllevelDims(2)-Img.imgHeight,W/2+Img.imgWidth/2,Y1-10-nulllevelDims(2)])
    Screen('TextSize', Win.win, Data.stimulus.fontSize.probabilities);
    if Data.ambigs(trial)==0
        Screen('Drawtext', Win.win, sprintf('%s',num2str(blueProb*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y2+(Y3-Y2)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
        Screen('Drawtext', Win.win, sprintf('%s',num2str(redProb*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y1+(Y2-Y1)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
    else
        Screen('Drawtext', Win.win, sprintf('%s',num2str((1-Data.ambigs(trial))/2*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y3occ+(Y3-Y3occ)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
        Screen('Drawtext', Win.win, sprintf('%s',num2str((1-Data.ambigs(trial))/2*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y1+(Y2occ-Y1)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
    end
elseif strcmp(Data.colorKey{Data.colors(trial)},'red') %red trial, up
    Screen('TextSize', Win.win, Data.stimulus.fontSize.lotteryValues);
    monlevelDims = getTextDims(Win.win,monlevel,Data.stimulus.fontSize.lotteryValues);
    Screen('DrawText', Win.win, monlevel,W/2-monlevelDims(1)/2, Y1-10-monlevelDims(2), Data.stimulus.fontColor);
    Screen('DrawTexture',Win.win,imgTexture,[],[W/2-Img.imgWidth/2,Y1-10-monlevelDims(2)-Img.imgHeight,W/2+Img.imgWidth/2,Y1-10-monlevelDims(2)]);

    nulllevelDims = getTextDims(Win.win,'$0',Data.stimulus.fontSize.lotteryValues);
    Screen('DrawText',Win.win, '$0',W/2-nulllevelDims(1)/2, Y3+10, Data.stimulus.fontColor); % $0
    Screen('DrawTexture',Win.win,Img.zeroTexture,[],[W/2-Img.imgWidth/2,Y3+10+nulllevelDims(2),W/2+Img.imgWidth/2,Y3+10+nulllevelDims(2)+Img.imgHeight])
   
    Screen('TextSize', Win.win, Data.stimulus.fontSize.probabilities);
    if Data.ambigs(trial)==0
        Screen('Drawtext', Win.win, sprintf('%s',num2str(blueProb*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y2+(Y3-Y2)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
        Screen('Drawtext', Win.win, sprintf('%s',num2str(redProb*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y1+(Y2-Y1)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
    else
        Screen('Drawtext', Win.win, sprintf('%s',num2str((1-Data.ambigs(trial))/2*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y3occ+(Y3-Y3occ)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
        Screen('Drawtext', Win.win, sprintf('%s',num2str((1-Data.ambigs(trial))/2*100)),W/2-Data.stimulus.textDims.probabilities(1)/2, Y1+(Y2occ-Y1)/2-Data.stimulus.textDims.probabilities(2)/2, Data.stimulus.fontColor);
    end
end

drawRef(Data,Win,Img)
Screen('flip',Win.win);

% Control lottory display time - for the Aging version: subjects have max 10s
% to view the lottery and are free to make choice whenever they feel ready
% to. Response time is also measured here.
elapsedTime=etime(datevec(now),Data.trialTime(trial).trialStartTime);
while elapsedTime<Data.stimulus.lottoDisplayDur % while the 10 seconds max is not reached
    [keyisdown, secs, keyCode, deltaSecs] = KbCheck;
    if keyisdown && (keyCode(KbName('2@')) || keyCode(KbName('1!'))) % 1 or 2 is pressed
        elapsedTime=etime(datevec(now),Data.trialTime(trial).trialStartTime); % response time
        break
    end
end

% % Draw green response cue, diameter=20
% Screen('FillOval', Win.win, [0 255 0], [Win.winrect(3)/2-20 Win.winrect(4)/2-20 Win.winrect(3)/2+20 Win.winrect(4)/2+20]);
% drawRef(Data,Win, Img)
% Screen('flip',Win.win);
% 
% % Response time
% Data.trialTime(trial).respStartTime=datevec(now);
% elapsedTime=etime(datevec(now),Data.trialTime(trial).respStartTime);
% while elapsedTime<Data.stimulus.responseWindowDur % while the resposne time limit is not reached
%     [keyisdown, secs, keyCode, deltaSecs] = KbCheck;
%     if keyisdown && (keyCode(KbName('2@')) || keyCode(KbName('1!'))) % 1 or 2 is pressed
%         elapsedTime=etime(datevec(now),Data.trialTime(trial).respStartTime); % response time
%         break
%     end
%     elapsedTime=etime(datevec(now),Data.trialTime(trial).respStartTime); % response time again, why?????????????????????????????
% end

% record response, and specify feedback drawing parameters
if keyisdown && keyCode(KbName('1!'))            %% Reversed keys '1' and '2' - DE
    Data.choice(trial)=1;
    Data.rt(trial)=elapsedTime;
    if Data.refSide==2 % if ref is on the right
        yellowDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        whiteDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    else
        yellowDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        whiteDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    end
    yellowColor=[255 255 0]; % yellow
elseif keyisdown && keyCode(KbName('2@'))        %% Reversed keys '2' and '1' - DE
    Data.choice(trial)=2;
    Data.rt(trial)=elapsedTime;
    if Data.refSide==2
        % how to calculate dims seems mysterious ??????????????????????????????????????
        whiteDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        yellowDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    else
        whiteDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        yellowDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    end
    Data.rt(trial)=elapsedTime;
    yellowColor=[255 255 0]; % yellow
else
    Data.choice(trial)=0;
    Data.rt(trial)=NaN;
    yellowColor=[255 255 255]; % white
    if Data.refSide==2
        whiteDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        yellowDims=[.5*Win.winrect(3)/10 -100 .5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    else
        whiteDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[4.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 4.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
        yellowDims=[-.5*Win.winrect(3)/10 -100 -.5*Win.winrect(3)/10 -100]+[5.5*Win.winrect(3)/10-20 Win.winrect(4)/2-20 5.5*Win.winrect(3)/10+20 Win.winrect(4)/2+20];
    end
end

% draw response feedback. On the same side of the reference lottery.
Screen(Win.win,'FillRect',yellowColor,yellowDims);
Screen(Win.win,'FillRect',[255 255 255],whiteDims);
drawRef(Data,Win, Img)
Screen('flip',Win.win);

% control feedback display time
Data.trialTime(trial).feedbackStartTime=datevec(now);
elapsedTime=etime(datevec(now),Data.trialTime(trial).feedbackStartTime);
while elapsedTime<Data.stimulus.feedbackDur
    elapsedTime=etime(datevec(now),Data.trialTime(trial).feedbackStartTime);
end

% draw ITI cue
Screen('FillOval', Win.win, [255 255 255], [Win.winrect(3)/2-20 Win.winrect(4)/2-20 Win.winrect(3)/2+20 Win.winrect(4)/2+20]);
drawRef(Data,Win, Img)
Screen('flip',Win.win);

% control ITI time
%Data.trialTime(trial).ITIStartTime=datevec(now);
elapsedTime=etime(datevec(now),Data.trialTime(trial).trialStartTime);
while elapsedTime<Data.stimulus.ITIDur %Data.stimulus.lottoDisplayDur+Data.stimulus.responseWindowDur+Data.stimulus.feedbackDur+Data.ITIs(trial)
    elapsedTime=etime(datevec(now),Data.trialTime(trial).trialStartTime);
end
end