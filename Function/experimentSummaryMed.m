%%
function Data=experimentSummaryMed(Data)
block=1;
trial=1;
for t=1:Data.numTrials
        if Data.choice(t)==1 && Data.refSide==2
            Data.Summary(block,trial).choice='Experimental treatment';
        elseif Data.choice(t)==2 && Data.refSide==1
            Data.Summary(block,trial).choice='Experimental treatment';
        elseif Data.choice(t)==0
            Data.Summary(block,trial).choice='None';
        else
            Data.Summary(block,trial).choice='Conservative treatment: Slight improvement';
        end

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

        if Data.vals(t)==5
            if Data.colors(t)==1
                Data.Summary(block,trial).blueValue=sprintf('slight improvement');
                Data.Summary(block,trial).redValue='no effect';
            elseif Data.colors(t)==2
                Data.Summary(block,trial).redValue=sprintf('slight improvement');
                Data.Summary(block,trial).blueValue='no effect';
            end
        elseif Data.vals(t) ==8
             if Data.colors(t)==1
                Data.Summary(block,trial).blueValue=sprintf('moderate improvement');
                Data.Summary(block,trial).redValue='no effect';
            elseif Data.colors(t)==2
                Data.Summary(block,trial).redValue=sprintf('moderate improvement');
                Data.Summary(block,trial).blueValue='no effect';
            end
         elseif Data.vals(t) ==12
             if Data.colors(t)==1
                Data.Summary(block,trial).blueValue=sprintf('major improvement');
                Data.Summary(block,trial).redValue='no effect';
            elseif Data.colors(t)==2
                Data.Summary(block,trial).redValue=sprintf('major improvement');
                Data.Summary(block,trial).blueValue='no effect';
            end
         elseif Data.vals(t) ==25
             if Data.colors(t)==1
                Data.Summary(block,trial).blueValue=sprintf('recovery');
                Data.Summary(block,trial).redValue='no effect';
            elseif Data.colors(t)==2
                Data.Summary(block,trial).redValue=sprintf('recovery');
                Data.Summary(block,trial).blueValue='no effect';
            end
        end 
        
    if trial ~=21
        trial=trial+1;
    else
        trial=1;
        block=block+1;
    end
end
end