%% function to wait for start key-number 5
function waitForBackTick;
while 1 % always true
    [keyisdown, secs, keyCode, deltaSecs] = KbCheck; % no need to indicate device number????
    % [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([deviceNumber])
    if keyisdown && keyCode(KbName('5'))==1 % check if 5 is pressed % 5%
        break
    end
end
end