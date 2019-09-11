function MDM_master(observer)
% clc;
% clear;
addpath(genpath('Z:\Aging\Medical Decision Making\Medical_DM_aging\Function'))
%% 1. What order should the blocks be run in?
% define 
Mon1 = @MDM_PTB_mon1_v2;
Mon2 = @MDM_PTB_mon2_v2;
Med1 = @MDM_PTB_med1_v2;
Med2 = @MDM_PTB_med2_v2;

% check the last digit of subject ID
d = 10;
r = mod(observer,d);% finds the unit digit of the observer number 
% y = (observer - r) / d % finds the tenth digit of the observer number
Mon = ismember(r, [1,2,5,6,9]);
Med = ismember(r, [0,3,4,7,8]);
if sum(Mon) > sum(Med)
    runFunction = {Mon1, Mon2, Med1, Med2}; % Monetary blocks go first
    
else
    runFunction = {Med1, Med2, Mon1, Mon2}; % Medical blocks go first
end
%% 2. Run blocks
for b = 1:length(runFunction)
runFunction{b}(observer);
Screen('Close')
end
Screen('CloseAll') % Close screen and psychtoolbox


