%% add Data.Summary
function Data=experimentSummary(Data)
block=1;
trial=1;
for t=1:Data.numTrials
        %choice
        if Data.choice(t)==1 && Data.refSide==2
            Data.Summary(block,trial).choice='Lottery';
        elseif Data.choice(t)==2 && Data.refSide==1
            Data.Summary(block,trial).choice='Lottery';
        elseif Data.choice(t)==0
            Data.Summary(block,trial).choice='None';
        else
            Data.Summary(block,trial).choice='Reference';
        end
        
        % bag number
        % first risk, then ambig, so that ambig trials with p=0.5 will be overitten
        if Data.probs(t)==.5
            Data.Summary(block,trial).bagNumber=4;
        elseif Data.probs(t)==.25 && Data.colors(t)==1
            Data.Summary(block,trial).bagNumber=3;
        elseif Data.probs(t)==.25 && Data.colors(t)==2
            Data.Summary(block,trial).bagNumber=5;
        elseif Data.probs(t)==.75 && Data.colors(t)==1
            Data.Summary(block,trial).bagNumber=5;
        elseif Data.probs(t)==.75 && Data.colors(t)==2
            Data.Summary(block,trial).bagNumber=3;
        end

        if Data.ambigs(t)==.24
            Data.Summary(block,trial).bagNumber=10;
        elseif Data.ambigs(t)==.5
            Data.Summary(block,trial).bagNumber=11;
        elseif Data.ambigs(t)==.74
            Data.Summary(block,trial).bagNumber=12;
        end

        if Data.colors(t)==1
            Data.Summary(block,trial).blueValue=sprintf('$%s',num2str(Data.vals(t)));
            Data.Summary(block,trial).redValue='$0';
        elseif Data.colors(t)==2
            Data.Summary(block,trial).redValue=sprintf('$%s',num2str(Data.vals(t)));
            Data.Summary(block,trial).blueValue='$0';
        end
    
    if trial ~=21
        trial=trial+1;
    else
        trial=1;
        block=block+1;
    end
end
end