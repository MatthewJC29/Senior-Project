%Generates the Simulink Environment
sys = 'Fig6_Auto';
new_system(sys)
open_system(sys)

count = 0;
init = 0;
sumcount = 0;
sumcount2 = 0;

Block_num = 'Number of blocks in the system: ';
block_count = input(Block_num);
%Starting Coordinates
x = 30;
y = 30;
w = 30;
h = 30;
offset = 60;

%while count <= block_count
    if init == 0
        blockone = 0;
        blocktwo = 0;
        blockthree = 0;
        blockfour = 0;
        blockfive = 0;
        blocksix = 0;
        blockseven = 0;
        blockeight = 0;
        blocknine = 0;
        blockten = 0;
        b1n = 'N/A';
        b2n = 'N/A';
        b3n = 'N/A';
        b4n = 'N/A';
        b5n = 'N/A';
        b6n = 'N/A';
        b7n = 'N/A';
        b8n = 'N/A';
        b9n = 'N/A';
        b10n = 'N/A';
        delay_num = 'How many delays in the system: ';
        delaynum = input(delay_num);
        disp('1:step, 2:sinusoid');
        block1 = 'Enter Input Type: ';
        blockone = input(block1);
        init = 1;
    end
    
    if blockone == 1
        input_time = 'Enter step time: ';
        intime = input(input_time);
        amplitude = 'Amplitude: ';
        amp = input(amplitude);
        pos = [x y+h/2 x+w y+h*1.4];
        add_block('built-in/Step',[sys '/Input1'],'Position',pos,...
        'Time',num2str(intime),'After',num2str(amp));
        b1n = 'Step Input';
        b1name = 'Input1/1';
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        block2 = 'Enter Second Block: ';
        blocktwo = input(block2);
        count = count+1;
        blockone = 0;
        conflag = 1;
    
    elseif blockone == 2
        amplitude = 'Amplitude: ';
        amp = input(amplitude);
        pos = [x y+h/2 x+w y+h*1.4];
        add_block('built-in/Sin',[sys '/Input1'],'Position',pos,...
        'Amplitude',num2str(amp));
        b1n = 'Sin Input';
        b1name = 'Input1/1';
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        block2 = 'Enter Second Block: ';
        blocktwo = input(block2);
        count = count+1;
        blockone = 0;
        conflag = 1;
    end
        if blocktwo == 1
            while sumcount <= delaynum
                if sumcount2 == 0
                    disp('1:+, 2:-');
                    in1 = ('Is input + or - feedback: ');
                    inone = input(in1);
                    if inone == 1
                        str1 = '+';
                        b2pos_1 = 'Feedback2/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    else
                        str1 = '-';
                        b2neg_1 = 'Feedback2/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    end
                    elseif sumcount2 == 1
                        in2 = ('Is first feedback loop + or -: ');
                        intwo = input(in2);
                    if intwo == 1
                        str2 = '+';
                        b2pos_2 = 'Feedback2/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    else
                        str2 = '-';
                        b2neg_2 = 'Feedback2/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    end
                    elseif sumcount2 == 2
                        in3 = ('Is second feedback loop + or -: ');
                        inthree = input(in3);
                    if inthree == 1
                        str3 = '+';
                        b2pos_3 = 'Feedback2/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    else
                        str3 = '-';
                        b2neg_3 = 'Feedback2/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    end
                end
            end
            if delaynum == 1
                fb = strcat('|',str1,str2);
            elseif delaynum == 2
                fb = strcat('|',str1,str2,str3);
            end
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.2];
            add_block('built-in/Sum',[sys '/Feedback2'],'Position',pos,...
            'IconShape','round','Inputs',fb)
            b2n = 'Sum';
            b2name = 'Feedback2/1';
            disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 2
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.2];
            satmin1 = 'Enter saturation lower limit: ';
            satminone = input(satmin1);
            satmax1 = 'enter saturation upper limit: ';
            satmaxone = input(satmax1);
            add_block('built-in/Saturate',[sys '/Sat2'],'Position',pos,...
            'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
            b2n = 'Saturation';
            b2name = 'Sat2/1';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 3
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.2];
            delay1 = 'Enter delay length: ';
            delayone = input(delay1);
            add_block('built-in/TransportDelay',[sys '/Delay2'],...
            'Position',pos,'Delaytime',num2str(delayone))
            b2n = 'Delay';
            b2name = 'Delay2/1';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 4
            gain1 = 'Gain: ';
            gainone = input(gain1);
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.2];
            add_block('built-in/Gain',[sys '/Gain2'],'Position',pos,...
            'Gain',num2str(gainone))
            b2n = 'Gain';
            b2name = 'Gain2/1';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 5
            disp('use format: ''[X1 X2]''');
            num1 = 'Enter TF numerator: ';
            numone = input(num1);
            den1 = 'Enter TF denominator: ';
            denone = input(den1);
            pos = [x+offset y+h/10 (x+w)+offset y+h*2];
            add_block('built-in/TransferFcn',[sys '/TF2'],'Position',pos,...
            'Numerator',numone,'Denominator',denone)
            b2n = 'TF';
            b2name = 'TF2/1';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 6
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.2];
            add_block('built-in/Integrator',[sys '/Integrator2'],'Position',pos)
            b2name = 'Integrator2/1';
            b2n = 'Integrator';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        elseif blocktwo == 7
            pos = [x+offset y+h/2 (x+w)+offset y+h*1.5];
            add_block('built-in/Scope',[sys '/Scope2'],'Position',pos)
            b2n = 'Scope';
            b2name = 'Scope2/1';
            block3 = 'Enter third Block: ';
            blockthree = input(block3);
            count = count+1;
            blocktwo = 0;
        end
    if blockthree == 1
        while sumcount <= delaynum
            if sumcount2 == 0
                disp('1:+, 2:-');
                in1 = ('Is input + or - feedback: ');
                inone = input(in1);
                if inone == 1
                    str1 = '+';
                    b3pos_1 = 'Feedback3/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                else
                    str1 = '-';
                    b3pos_1 = 'Feedback3/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                end
                elseif sumcount2 == 1
                    in2 = ('Is first feedback loop + or -: ');
                    intwo = input(in2);
                if intwo == 1
                    str2 = '+';
                    b3pos_2 = 'Feedback3/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                else
                    str2 = '-';
                    b3pos_2 = 'Feedback3/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                end
                elseif sumcount2 == 2
                    in3 = ('Is second feedback loop + or -: ');
                    inthree = input(in3);
                if inthree == 1
                    str3 = '+';
                    b3pos_3 = 'Feedback3/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                else
                    str3 = '-';
                    b3pos_3 = 'Feedback3/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                end
            end
        end
        if delaynum == 1
            fb = strcat('|',str1,str2);
        elseif delaynum == 2
            fb = strcat('|',str1,str2,str3);
        end
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.2];
        add_block('built-in/Sum',[sys '/Feedback3'],'Position',pos,...
    	'IconShape','round','Inputs',fb)
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        b3n = 'Sum';
        b3name = 'Feedback3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 2
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.2];
        satmin1 = 'Enter saturation lower limit: ';
        satminone = input(satmin1);
        satmax1 = 'enter saturation upper limit: ';
        satmaxone = input(satmax1);
        add_block('built-in/Saturate',[sys '/Sat3'],'Position',pos,...
        'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
        b3n = 'Saturation';
        b3name = 'Sat3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 3
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.2];
        delay1 = 'Enter delay length: ';
        delayone = input(delay1);
        add_block('built-in/TransportDelay',[sys '/Delay3'],...
            'Position',pos,'Delaytime',num2str(delayone))
        b3n = 'Delay';
        b3name = 'Delay3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 4
        gain1 = 'Gain: ';
        gainone = input(gain1);
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.2];
        add_block('built-in/Gain',[sys '/Gain3'],'Position',pos,...
        'Gain',num2str(gainone))
        b3n = 'Gain';
        b3name = 'Gain3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 5
        disp('use format: ''[X1 X2]''');
        num1 = 'Enter TF numerator: ';
        numone = input(num1);
        den1 = 'Enter TF denominator: ';
        denone = input(den1);
        pos = [x+offset*2 y+h/10 (x+w)+offset*2 y+h*2];
        add_block('built-in/TransferFcn',[sys '/TF3'],'Position',pos,...
        'Numerator',numone,'Denominator',denone)
        b3n = 'TF';
        b3name = 'TF3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 6
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.2];
        add_block('built-in/Integrator',[sys '/Integrator3'],'Position',pos)
        b3name = 'Integrator3/1';
        b3n = 'Integrator';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    elseif blockthree == 7
        pos = [x+offset*2 y+h/2 (x+w)+offset*2 y+h*1.5];
        add_block('built-in/Scope',[sys '/Scope3'],'Position',pos)
        b3n = 'Scope';
        b3name = 'Scope3/1';
        block4 = 'Enter Fourth Block: ';
        blockfour = input(block4);
        count = count+1;
        blockthree = 0;
    end
    if blockfour == 1
        while sumcount <= delaynum
            if sumcount2 == 0
                disp('1:+, 2:-');
                in1 = ('Is input + or - feedback: ');
                inone = input(in1);
                if inone == 1
                    str1 = '+';
                    b4pos_1 = 'Feedback4/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                else
                    str1 = '-';
                    b4neg_1 = 'Feedback4/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                end
                elseif sumcount2 == 1
                    in2 = ('Is first feedback loop + or -: ');
                    intwo = input(in2);
                if intwo == 1
                    str2 = '+';
                    b4pos_2 = 'Feedback4/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                else
                    str2 = '-';
                    b4neg_2 = 'Feedback4/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                end
                elseif sumcount2 == 2
                    in3 = ('Is second feedback loop + or -: ');
                    inthree = input(in3);
                if inthree == 1
                    str3 = '+';
                    b4pos_3 = 'Feedback4/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                else
                    str3 = '-';
                    b4neg_3 = 'Feedback4/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                end
            end
        end
        if delaynum == 1
            fb = strcat('|',str1,str2);
        elseif delaynum == 2
            fb = strcat('|',str1,str2,str3);
        end
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.2];
        add_block('built-in/Sum',[sys '/Feedback4'],'Position',pos,...
    	'IconShape','round','Inputs',fb)
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        b4n = 'Sum';
        b4name = 'Feedback4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 2
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.2];
        satmin1 = 'Enter saturation lower limit: ';
        satminone = input(satmin1);
        satmax1 = 'enter saturation upper limit: ';
        satmaxone = input(satmax1);
        add_block('built-in/Saturate',[sys '/Sat4'],'Position',pos,...
        'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
        b4n = 'Saturation';
        b4name = 'Sat4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 3
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.2];
        delay1 = 'Enter delay length: ';
        delayone = input(delay1);
        add_block('built-in/TransportDelay',[sys '/Delay4'],...
            'Position',pos,'Delaytime',num2str(delayone))
        b4n = 'Delay';
        b4name = 'Delay4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 4
        gain1 = 'Gain: ';
        gainone = input(gain1);
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.2];
        add_block('built-in/Gain',[sys '/Gain4'],'Position',pos,...
        'Gain',num2str(gainone))
        b4n = 'Gain';
        b4name = 'Gain4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 5
        disp('use format: ''[X1 X2]''');
        num1 = 'Enter TF numerator: ';
        numone = input(num1);
        den1 = 'Enter TF denominator: ';
        denone = input(den1);
        pos = [x+offset*3 y+h/10 (x+w)+offset*3 y+h*2];
        add_block('built-in/TransferFcn',[sys '/TF4'],'Position',pos,...
        'Numerator',numone,'Denominator',denone)
        b4n = 'TF';
        b4name = 'TF4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 6
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.2];
        add_block('built-in/Integrator',[sys '/Integrator4'],'Position',pos)
        b4name = 'Integrator4/1';
        b4n = 'Integrator';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    elseif blockfour == 7
        pos = [x+offset*3 y+h/2 (x+w)+offset*3 y+h*1.5];
        add_block('built-in/Scope',[sys '/Scope4'],'Position',pos)
        b4n = 'Scope';
        b4name = 'Scope4/1';
        block5 = 'Enter Fifth Block: ';
        blockfive = input(block5);
        count = count+1;
        blockfour = 0;
    end
    if blockfive == 1
        while sumcount <= delaynum
            if sumcount2 == 0
                disp('1:+, 2:-');
                in1 = ('Is input + or - feedback: ');
                inone = input(in1);
                if inone == 1
                    str1 = '+';
                    b5pos_1 = 'Feedback5/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                else
                    str1 = '-';
                    b5neg_1 = 'Feedback5/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                end
                elseif sumcount2 == 1
                    in2 = ('Is first feedback loop + or -: ');
                    intwo = input(in2);
                if intwo == 1
                    str2 = '+';
                    b5pos_2 = 'Feedback5/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                else
                    str2 = '-';
                    b5neg_2 = 'Feedback5/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                end
                elseif sumcount2 == 2
                    in3 = ('Is second feedback loop + or -: ');
                    inthree = input(in3);
                if inthree == 1
                    str3 = '+';
                    b5pos_3 = 'Feedback5/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                else
                    str3 = '-';
                    b5pos_3 = 'Feedback5/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                end
            end
        end
        if delaynum == 1
            fb = strcat('|',str1,str2);
        elseif delaynum == 2
            fb = strcat('|',str1,str2,str3);
        end
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.2];
        add_block('built-in/Sum',[sys '/Feedback5'],'Position',pos,...
    	'IconShape','round','Inputs',fb)
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        b5n = 'Sum';
        b5name = 'Feedback5/1';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 2
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.2];
        satmin1 = 'Enter saturation lower limit: ';
        satminone = input(satmin1);
        satmax1 = 'enter saturation upper limit: ';
        satmaxone = input(satmax1);
        add_block('built-in/Saturate',[sys '/Sat5'],'Position',pos,...
        'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
        b5n = 'Saturation';
        b5name = 'Sat5/1';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 3
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.2];
        delay1 = 'Enter delay length: ';
        delayone = input(delay1);
        add_block('built-in/TransportDelay',[sys '/Delay5'],...
            'Position',pos,'Delaytime',num2str(delayone))
        b5n = 'Delay';
        b5name = 'Delay5/1';
        block6 = 'Enter sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 4
        gain1 = 'Gain: ';
        gainone = input(gain1);
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.2];
        add_block('built-in/Gain',[sys '/Gain5'],'Position',pos,...
        'Gain',num2str(gainone))
        b5n = 'Gain';
        b5name = 'Gain5/1';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 5
        disp('use format: ''[X1 X2]''');
        num1 = 'Enter TF numerator: ';
        numone = input(num1);
        den1 = 'Enter TF denominator: ';
        denone = input(den1);
        pos = [x+offset*4 y+h/10 (x+w)+offset*4 y+h*2];
        add_block('built-in/TransferFcn',[sys '/TF5'],'Position',pos,...
        'Numerator',numone,'Denominator',denone)
        b5n = 'TF';
        b5name = 'TF5/1';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 6
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.2];
        add_block('built-in/Integrator',[sys '/Integrator5'],'Position',pos)
        b5name = 'Integrator5/1';
        b5n = 'Integrator';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    elseif blockfive == 7
        pos = [x+offset*4 y+h/2 (x+w)+offset*4 y+h*1.5];
        add_block('built-in/Scope',[sys '/Scope5'],'Position',pos)
        b5name = 'Scope5/1';
        b5n = 'Scope';
        block6 = 'Enter Sixth Block: ';
        blocksix = input(block6);
        count = count+1;
        blockfive = 0;
    end
    if blocksix == 1
        while sumcount <= delaynum
            if sumcount2 == 0
                disp('1:+, 2:-');
                in1 = ('Is input + or - feedback: ');
                inone = input(in1);
                if inone == 1
                    str1 = '+';
                    b6pos_1 = 'Feedback6/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                else
                    str1 = '-';
                    b6neg_1 = 'Feedback6/1';
                    sumcount = sumcount + 1;
                    sumcount2 = 1;
                end
                elseif sumcount2 == 1
                    in2 = ('Is first feedback loop + or -: ');
                    intwo = input(in2);
                if intwo == 1
                    str2 = '+';
                    b6pos_2 = 'Feedback6/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                else
                    str2 = '-';
                    b6neg_2 = 'Feedback6/2';
                    sumcount = sumcount + 1;
                    sumcount2 = 2;
                end
                elseif sumcount2 == 2
                    in3 = ('Is second feedback loop + or -: ');
                    inthree = input(in3);
                if inthree == 1
                    str3 = '+';
                    b6pos_3 = 'Feedback6/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                else
                    str3 = '-';
                    b6neg_3 = 'Feedback6/3';
                    sumcount = sumcount + 1;
                    sumcount2 = 3;
                end
            end
        end
        if delaynum == 1
            fb = strcat('|',str1,str2);
        elseif delaynum == 2
            fb = strcat('|',str1,str2,str3);
        end
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.2];
        add_block('built-in/Sum',[sys '/Feedback6'],'Position',pos,...
    	'IconShape','round','Inputs',fb)
        disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
        b6n = 'Sum';
        b6name = 'Feedback6/1';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 2
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.2];
        satmin1 = 'Enter saturation lower limit: ';
        satminone = input(satmin1);
        satmax1 = 'enter saturation upper limit: ';
        satmaxone = input(satmax1);
        add_block('built-in/Saturate',[sys '/Sat6'],'Position',pos,...
        'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
        b6n = 'Saturation';
        b6name = 'Sat6/1';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 3
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.2];
        delay1 = 'Enter delay length: ';
        delayone = input(delay1);
        add_block('built-in/TransportDelay',[sys '/Delay6'],...
            'Position',pos,'Delaytime',num2str(delayone))
        b6n = 'Delay';
        b6name = 'Delay6/1';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 4
        gain1 = 'Gain: ';
        gainone = input(gain1);
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.2];
        add_block('built-in/Gain',[sys '/Gain6'],'Position',pos,...
        'Gain',num2str(gainone))
        b6n = 'Gain';
        b6name = 'Gain6/1';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 5
        disp('use format: ''[X1 X2]''');
        num1 = 'Enter TF numerator: ';
        numone = input(num1);
        den1 = 'Enter TF denominator: ';
        denone = input(den1);
        pos = [x+offset*5 y+h/10 (x+w)+offset*5 y+h*2];
        add_block('built-in/TransferFcn',[sys '/TF6'],'Position',pos,...
        'Numerator',numone,'Denominator',denone)
        b6n = 'TF';
        b6name = 'TF6/1';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 6
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.2];
        add_block('built-in/Integrator',[sys '/Integrator6'],'Position',pos)
        b6name = 'Integrator6/1';
        b6n = 'Integrator';
        block7 = 'Enter Seventh Block: ';
        blockseven = input(block7);
        count = count+1;
        blocksix = 0;
    elseif blocksix == 7
        pos = [x+offset*5 y+h/2 (x+w)+offset*5 y+h*1.5];
        add_block('built-in/Scope',[sys '/Scope6'],'Position',pos)
        b6n = 'Scope';
        b6name = 'Scope6/1';
        block7 = 'Enter Seventh Block: ';
        if block_count-1 == count
            count = block_count;
        else
            blockseven = input(block7);
            count = count+1;
        end
        blocksix = 0;
    end
    if blockseven == 1 
            while sumcount <= delaynum
                if sumcount2 == 0
                    disp('1:+, 2:-');
                    in1 = ('Is input + or - feedback: ');
                    inone = input(in1);
                    if inone == 1
                        str1 = '+';
                        b7pos_1 = 'Feedback7/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    else
                        str1 = '-';
                        b7neg_1 = 'Feedback7/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    end
                    elseif sumcount2 == 1
                        in2 = ('Is first feedback loop + or -: ');
                        intwo = input(in2);
                    if intwo == 1
                        str2 = '+';
                        b7pos_2 = 'Feedback7/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    else
                        str2 = '-';
                        b7neg_2 = 'Feedback7/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    end
                    elseif sumcount2 == 2
                        in3 = ('Is second feedback loop + or -: ');
                        inthree = input(in3);
                    if inthree == 1
                        str3 = '+';
                        b7pos_3 = 'Feedback7/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    else
                        str3 = '-';
                        b7neg_3 = 'Feedback7/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    end
                end
            end
            if delaynum == 1
                fb = strcat('|',str1,str2);
            elseif delaynum == 2
                fb = strcat('|',str1,str2,str3);
            end
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.2];
            add_block('built-in/Sum',[sys '/Feedback7'],'Position',pos,...
            'IconShape','round','Inputs',fb)
            disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
            b7n = 'Sum';
            b7name = 'Feedback7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 2
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.2];
            satmin1 = 'Enter saturation lower limit: ';
            satminone = input(satmin1);
            satmax1 = 'enter saturation upper limit: ';
            satmaxone = input(satmax1);
            add_block('built-in/Saturate',[sys '/Sat7'],'Position',pos,...
            'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
            b7n = 'Saturation';
            b7name = 'Sat7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 3
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.2];
            delay1 = 'Enter delay length: ';
            delayone = input(delay1);
            add_block('built-in/TransportDelay',[sys '/Delay7'],...
            'Position',pos,'Delaytime',num2str(delayone))
            b7n = 'Delay';
            b7name = 'Delay7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 4
            gain1 = 'Gain: ';
            gainone = input(gain1);
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.2];
            add_block('built-in/Gain',[sys '/Gain'],'Position',pos,...
            'Gain',num2str(gainone))
            b7n = 'Gain';
            b7name = 'Gain7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 5
            disp('use format: ''[X1 X2]''');
            num1 = 'Enter TF numerator: ';
            numone = input(num1);
            den1 = 'Enter TF denominator: ';
            denone = input(den1);
            pos = [x+offset*6 y+h/10 (x+w)+offset*6 y+h*2];
            add_block('built-in/TransferFcn',[sys '/TF7'],'Position',pos,...
            'Numerator',numone,'Denominator',denone)
            b7n = 'TF';
            b7name = 'TF7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 6
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.2];
            add_block('built-in/Integrator',[sys '/Integrator7'],'Position',pos)
            b7name = 'Integrator7/1';
            b7n = 'Integrator';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockseven == 7
            pos = [x+offset*6 y+h/2 (x+w)+offset*6 y+h*1.5];
            add_block('built-in/Scope',[sys '/Scope7'],'Position',pos)
            b7n = 'Scope';
            b7name = 'Scope7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
    end
    if blockeight == 1 
            while sumcount <= delaynum
                if sumcount2 == 0
                    disp('1:+, 2:-');
                    in1 = ('Is input + or - feedback: ');
                    inone = input(in1);
                    if inone == 1
                        str1 = '+';
                        b8pos_1 = 'Feedback8/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    else
                        str1 = '-';
                        b8neg_1 = 'Feedback8/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    end
                    elseif sumcount2 == 1
                        in2 = ('Is first feedback loop + or -: ');
                        intwo = input(in2);
                    if intwo == 1
                        str2 = '+';
                        b8pos_2 = 'Feedback8/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    else
                        str2 = '-';
                        b8neg_2 = 'Feedback8/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    end
                    elseif sumcount2 == 2
                        in3 = ('Is second feedback loop + or -: ');
                        inthree = input(in3);
                    if inthree == 1
                        str3 = '+';
                        b8pos_3 = 'Feedback8/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    else
                        str3 = '-';
                        b8neg_3 = 'Feedback8/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    end
                end
            end
            if delaynum == 1
                fb = strcat('|',str1,str2);
            elseif delaynum == 2
                fb = strcat('|',str1,str2,str3);
            end
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.2];
            add_block('built-in/Sum',[sys '/Feedback8'],'Position',pos,...
            'IconShape','round','Inputs',fb)
            disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
            b8n = 'Sum';
            b8name = 'Feedback8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 2
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.2];
            satmin1 = 'Enter saturation lower limit: ';
            satminone = input(satmin1);
            satmax1 = 'enter saturation upper limit: ';
            satmaxone = input(satmax1);
            add_block('built-in/Saturate',[sys '/Sat8'],'Position',pos,...
            'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
            b8n = 'Saturation';
            b8name = 'Sat8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 3
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.2];
            delay1 = 'Enter delay length: ';
            delayone = input(delay1);
            add_block('built-in/TransportDelay',[sys '/Delay8'],...
            'Position',pos,'Delaytime',num2str(delayone))
            b8n = 'Delay';
            b8name = 'Delay8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 4
            gain1 = 'Gain: ';
            gainone = input(gain1);
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.2];
            add_block('built-in/Gain',[sys '/Gain8'],'Position',pos,...
            'Gain',num2str(gainone))
            b8n = 'Gain';
            b8name = 'Gain8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 5
            disp('use format: ''[X1 X2]''');
            num1 = 'Enter TF numerator: ';
            numone = input(num1);
            den1 = 'Enter TF denominator: ';
            denone = input(den1);
            pos = [x+offset*7 y+h/10 (x+w)+offset*7 y+h*2];
            add_block('built-in/TransferFcn',[sys '/TF8'],'Position',pos,...
            'Numerator',numone,'Denominator',denone)
            b8n = 'TF';
            b8name = 'TF8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 6
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.2];
            add_block('built-in/Integrator',[sys '/Integrator8'],'Position',pos)
            b8name = 'Integrator8/1';
            b8n = 'Integrator';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
        elseif blockeight == 7
            pos = [x+offset*7 y+h/2 (x+w)+offset*7 y+h*1.5];
            add_block('built-in/Scope',[sys '/Scope8'],'Position',pos)
            b8n = 'Scope';
            b8name = 'Scope8/1';
            block9 = 'Enter Ninth Block: ';
            blocknine = input(block9);
            count = count+1;
            blockeight = 0;
    end
    if blocknine == 1
            while sumcount <= delaynum
                if sumcount2 == 0
                    disp('1:+, 2:-');
                    in1 = ('Is input + or - feedback: ');
                    inone = input(in1);
                    if inone == 1
                        str1 = '+';
                        b9pos_1 = 'Feedback9/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    else
                        str1 = '-';
                        b9neg_1 = 'Feedback9/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    end
                    elseif sumcount2 == 1
                        in2 = ('Is first feedback loop + or -: ');
                        intwo = input(in2);
                    if intwo == 1
                        str2 = '+';
                        b9pos_2 = 'Feedback9/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    else
                        str2 = '-';
                        b9neg_2 = 'Feedback9/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    end
                    elseif sumcount2 == 2
                        in3 = ('Is second feedback loop + or -: ');
                        inthree = input(in3);
                    if inthree == 1
                        str3 = '+';
                        b9pos_3 = 'Feedback9/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    else
                        str3 = '-';
                        b9neg_3 = 'Feedback9/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    end
                end
            end
            if delaynum == 1
                fb = strcat('|',str1,str2);
            elseif delaynum == 2
                fb = strcat('|',str1,str2,str3);
            end
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.2];
            add_block('built-in/Sum',[sys '/Feedback9'],'Position',pos,...
            'IconShape','round','Inputs',fb)
            disp('1:summing, 2:Saturation, 3:Delay, 4:Gain, 5:TF, 6: Integrator, 7:Scope');
            b9n = 'Sum';
            b9name = 'Feedback9/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 2
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.2];
            satmin1 = 'Enter saturation lower limit: ';
            satminone = input(satmin1);
            satmax1 = 'enter saturation upper limit: ';
            satmaxone = input(satmax1);
            add_block('built-in/Saturate',[sys '/Sat9'],'Position',pos,...
            'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
            b9n = 'Saturation';
            b9name = 'Sat9/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 3
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.2];
            delay1 = 'Enter delay length: ';
            delayone = input(delay1);
            add_block('built-in/TransportDelay',[sys '/Delay9'],...
            'Position',pos,'Delaytime',num2str(delayone))
            b9n = 'Delay';
            b9name = 'Delay7/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 4
            gain1 = 'Gain: ';
            gainone = input(gain1);
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.2];
            add_block('built-in/Gain',[sys '/Gain9'],'Position',pos,...
            'Gain',num2str(gainone))
            b9n = 'Gain';
            b9name = 'Gain9/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 5
            disp('use format: ''[X1 X2]''');
            num1 = 'Enter TF numerator: ';
            numone = input(num1);
            den1 = 'Enter TF denominator: ';
            denone = input(den1);
            pos = [x+offset*8 y+h/10 (x+w)+offset*8 y+h*2];
            add_block('built-in/TransferFcn',[sys '/TF9'],'Position',pos,...
            'Numerator',numone,'Denominator',denone)
            b9n = 'TF';
            b9name = 'TF9/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 6
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.2];
            add_block('built-in/Integrator',[sys '/Integrator9'],'Position',pos)
            b9name = 'Integrator9/1';
            b9n = 'Integrator';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
        elseif blocknine == 7
            pos = [x+offset*8 y+h/2 (x+w)+offset*8 y+h*1.5];
            add_block('built-in/Scope',[sys '/Scope9'],'Position',pos)
            b9n = 'Scope';
            b9name = 'Scope9/1';
            block10 = 'Enter Tenth Block: ';
            blockten = input(block10);
            count = count+1;
            blocknine = 0;
            if block_count-1 == count
            count = block_count;
            else
                blockten = input(block10);
                count = count+1;
            end
            blocknine = 0;
    end
    if blockten == 1 
        if count ~= block_count
            while sumcount <= delaynum
                if sumcount2 == 0
                    disp('1:+, 2:-');
                    in1 = ('Is input + or - feedback: ');
                    inone = input(in1);
                    if inone == 1
                        str1 = '+';
                        b7pos_1 = 'Feedback7/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    else
                        str1 = '-';
                        b7neg_1 = 'Feedback7/1';
                        sumcount = sumcount + 1;
                        sumcount2 = 1;
                    end
                    elseif sumcount2 == 1
                        in2 = ('Is first feedback loop + or -: ');
                        intwo = input(in2);
                    if intwo == 1
                        str2 = '+';
                        b7pos_2 = 'Feedback7/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    else
                        str2 = '-';
                        b7neg_2 = 'Feedback7/2';
                        sumcount = sumcount + 1;
                        sumcount2 = 2;
                    end
                    elseif sumcount2 == 2
                        in3 = ('Is second feedback loop + or -: ');
                        inthree = input(in3);
                    if inthree == 1
                        str3 = '+';
                        b7pos_3 = 'Feedback7/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    else
                        str3 = '-';
                        b7neg_3 = 'Feedback7/3';
                        sumcount = sumcount + 1;
                        sumcount2 = 3;
                    end
                end
            end
            if delaynum == 1
                fb = strcat('|',str1,str2);
            elseif delaynum == 2
                fb = strcat('|',str1,str2,str3);
            end
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.2];
            add_block('built-in/Sum',[sys '/Feedback10'],'Position',pos,...
            'IconShape','round','Inputs',fb)
            count = count+1;
            blockseven = 0;
        elseif blockten == 2
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.2];
            satmin1 = 'Enter saturation lower limit: ';
            satminone = input(satmin1);
            satmax1 = 'enter saturation upper limit: ';
            satmaxone = input(satmax1);
            add_block('built-in/Saturate',[sys '/Sat7'],'Position',pos,...
            'UpperLimit',num2str(satmaxone),'LowerLimit',num2str(satminone));
            b7n = 'Saturation';
            b7name = 'Sat7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockten == 3
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.2];
            delay1 = 'Enter delay length: ';
            delayone = input(delay1);
            add_block('built-in/TransportDelay',[sys '/Delay7'],...
            'Position',pos,'Delaytime',num2str(delayone))
            b7n = 'Delay';
            b7name = 'Delay7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockten == 4
            gain1 = 'Gain: ';
            gainone = input(gain1);
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.2];
            add_block('built-in/Gain',[sys '/Gain'],'Position',pos,...
            'Gain',num2str(gainone))
            b7n = 'Gain';
            b7name = 'Gain7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockten == 5
            disp('use format: ''[X1 X2]''');
            num1 = 'Enter TF numerator: ';
            numone = input(num1);
            den1 = 'Enter TF denominator: ';
            denone = input(den1);
            pos = [x+offset*9 y+h/10 (x+w)+offset*9 y+h*2];
            add_block('built-in/TransferFcn',[sys '/TF7'],'Position',pos,...
            'Numerator',numone,'Denominator',denone)
            b7n = 'TF';
            b7name = 'TF7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockten == 6
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.2];
            add_block('built-in/Integrator',[sys '/Integrator7'],'Position',pos)
            b7name = 'Integrator7/1';
            b7n = 'Integrator';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        elseif blockten == 7
            pos = [x+offset*9 y+h/2 (x+w)+offset*9 y+h*1.5];
            add_block('built-in/Scope',[sys '/Scope7'],'Position',pos)
            b7n = 'Scope';
            b7name = 'Scope7/1';
            block8 = 'Enter Eighth Block: ';
            blockeight = input(block8);
            count = count+1;
            blockseven = 0;
        end
    end
    if conflag == 1
        c1count = ('How many blocks is the output of block1 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                add_line(sys,b1name,b2name,autorouting,'on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                disp(H1);
                b1multcon1 = ('Enter First connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b1name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b1name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b1name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b1name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b1name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b1name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b1name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b1name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b1name,b10name,'autorouting','on')
                end
            end
        end
        c1count = ('How many blocks is the output of block2 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1name,b2neg_1,'autorouting','on')
                end
            else
                add_line(sys,b2name,b3name,'autorouting','on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                b1multcon1 = ('Enter First connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b2name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b2name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b2name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b2name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b2name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b2name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b2name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b2name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b2name,b10name,'autorouting','on')
                end
            end
        end
        c1count = ('How many blocks is the output of block3 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                add_line(sys,b3name,b4name,'autorouting','on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                b1multcon1 = ('Enter First connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b3name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b3name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b3name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b3name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b3name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b3name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b3name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b3name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b3name,b10name,'autorouting','on')
                end
                b1multcon2 = ('Enter second connection: ');
                b1mcon2 = input(b1multcon2);
                if b1mcon2 == 2
                    add_line(sys,b3name,b2name,'autorouting','on')
                elseif b1mcon2 == 3
                    add_line(sys,b3name,b3name,'autorouting','on')
                elseif b1mcon2 == 4
                    add_line(sys,b3name,b4name,'autorouting','on')
                elseif b1mcon2 == 5
                    add_line(sys,b3name,b5name,'autorouting','on')
                elseif b1mcon2 == 6
                    add_line(sys,b3name,b6name,'autorouting','on')
                elseif b1mcon2 == 7
                    add_line(sys,b3name,b7name,'autorouting','on')
                elseif b1mcon2 == 8
                    add_line(sys,b3name,b8name,'autorouting','on')
                elseif b1mcon2 == 9
                    add_line(sys,b3name,b9name,'autorouting','on')
                elseif b1mcon2 == 10
                    add_line(sys,b3name,b10name,'autorouting','on')
                end
            end 
        end
        c1count = ('How many blocks is the output of block4 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                add_line(sys,b4name,b5name,'autorouting','on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                b1multcon1 = ('Enter First connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b4name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b4name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b4name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b4name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b4name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b4name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b4name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b4name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b4name,b10name,'autorouting','on')
                end
                b1multcon2 = ('Enter second connection: ');
                b1mcon2 = input(b1multcon2);
                if b1mcon2 == 2
                    add_line(sys,b4name,b2name,'autorouting','on')
                elseif b1mcon2 == 3
                    add_line(sys,b4name,b3name,'autorouting','on')
                elseif b1mcon2 == 4
                    add_line(sys,b4name,b4name,'autorouting','on')
                elseif b1mcon2 == 5
                    add_line(sys,b4name,b5name,'autorouting','on')
                elseif b1mcon2 == 6
                    add_line(sys,b4name,b6name,'autorouting','on')
                elseif b1mcon2 == 7
                    add_line(sys,b4name,b7name,'autorouting','on')
                elseif b1mcon2 == 8
                    add_line(sys,b4name,b8name,'autorouting','on')
                elseif b1mcon2 == 9
                    add_line(sys,b4name,b9name,'autorouting','on')
                elseif b1mcon2 == 10
                    add_line(sys,b4name,b10name,'autorouting','on')
                end
            end 
        end
        c1count = ('How many blocks is the output of block5 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b5name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b5name,b2neg_2,'autorouting','on')
                end
            else
                add_line(sys,b5name,b6name,'autorouting','on')
            end
        elseif c1con > 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b5name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b5name,b2neg_2,'autorouting','on')
                end
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n,...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                b1multcon1 = ('Enter Next connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b5name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b5name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b5name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b5name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b5name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b5name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b5name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b5name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b5name,b10name,'autorouting','on')
                end
            end
        end
        c1count = ('How many blocks is the output of block6 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b6name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b6name,b2neg_2,'autorouting','on')
                end
            else
                add_line(sys,b6name,b7name,'autorouting','on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                b1multcon1 = ('Enter First connection: ');
                b1mcon1 = input(b1multcon1);
                if b1mcon1 == 2
                    add_line(sys,b6name,b2name,'autorouting','on')
                elseif b1mcon1 == 3
                    add_line(sys,b6name,b3name,'autorouting','on')
                elseif b1mcon1 == 4
                    add_line(sys,b6name,b4name,'autorouting','on')
                elseif b1mcon1 == 5
                    add_line(sys,b6name,b5name,'autorouting','on')
                elseif b1mcon1 == 6
                    add_line(sys,b6name,b6name,'autorouting','on')
                elseif b1mcon1 == 7
                    add_line(sys,b6name,b7name,'autorouting','on')
                elseif b1mcon1 == 8
                    add_line(sys,b6name,b8name,'autorouting','on')
                elseif b1mcon1 == 9
                    add_line(sys,b6name,b9name,'autorouting','on')
                elseif b1mcon1 == 10
                    add_line(sys,b6name,b10name,'autorouting','on')
                end
                b1multcon2 = ('Enter second connection: ');
                b1mcon2 = input(b1multcon2);
                if b1mcon2 == 2
                    add_line(sys,b6name,b2name,'autorouting','on')
                elseif b1mcon2 == 3
                    add_line(sys,b6name,b3name,'autorouting','on')
                elseif b1mcon2 == 4
                    add_line(sys,b6name,b4name,'autorouting','on')
                elseif b1mcon2 == 5
                    add_line(sys,b6name,b5name,'autorouting','on')
                elseif b1mcon2 == 6
                    add_line(sys,b6name,b6name,'autorouting','on')
                elseif b1mcon2 == 7
                    add_line(sys,b6name,b7name,'autorouting','on')
                elseif b1mcon2 == 8
                    add_line(sys,b6name,b8name,'autorouting','on')
                elseif b1mcon2 == 9
                    add_line(sys,b6name,b9name,'autorouting','on')
                elseif b1mcon2 == 10
                    add_line(sys,b6name,b10name,'autorouting','on')
                end
            end 
        end
        c1count = ('How many blocks is the output of block7 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b7name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b7name,b2neg_3,'autorouting','on')
                end
            else
                add_line(sys,b7name,b8name,'autorouting','on')
            end
        elseif c1con == 2
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
			if out1 == 1
				disp('1:+, 2:-');
				sum_pon = ('Does this connect to + or - feedback: ');
				spon = input(sum_pon);
				if spon == 1
					add_line(sys,b7name,b2pos_1,'autorouting','on')
				elseif spon ==2
					add_line(sys,b7name,b2neg_3,'autorouting','on')
				end
			else
				disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
				', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
				b1multcon1 = ('Enter first connection: ');
				b1mcon1 = input(b1multcon1);
				if b1mcon1 == 2
					add_line(sys,b7name,b2name,'autorouting','on')
				elseif b1mcon1 == 3
					add_line(sys,b7name,b3name,'autorouting','on')
				elseif b1mcon1 == 4
					add_line(sys,b7name,b4name,'autorouting','on')
				elseif b1mcon1 == 5
					add_line(sys,b7name,b5name,'autorouting','on')
				elseif b1mcon1 == 6
					add_line(sys,b7name,b6name,'autorouting','on')
				elseif b1mcon1 == 7
					add_line(sys,b7name,b7name,'autorouting','on')
				elseif b1mcon1 == 8
					add_line(sys,b7name,b8name,'autorouting','on')
				elseif b1mcon1 == 9
					add_line(sys,b7name,b9name,'autorouting','on')
				elseif b1mcon1 == 10
					add_line(sys,b7name,b10name,'autorouting','on')
				newcount= newcount + 1;
				end
				b1multcon2 = ('Enter next connection: ');
				b1mcon2 = input(b1multcon2);
				if b1mcon2 == 2
					add_line(sys,b7name,b2name,'autorouting','on')
				elseif b1mcon2 == 3
					add_line(sys,b7name,b3name,'autorouting','on')
				elseif b1mcon2 == 4
					add_line(sys,b7name,b4name,'autorouting','on')
				elseif b1mcon2 == 5
					add_line(sys,b7name,b5name,'autorouting','on')
				elseif b1mcon2 == 6
					add_line(sys,b7name,b6name,'autorouting','on')
				elseif b1mcon2 == 7
					add_line(sys,b7name,b7name,'autorouting','on')
				elseif b1mcon2 == 8
					add_line(sys,b7name,b8name,'autorouting','on')
				elseif b1mcon2 == 9
					add_line(sys,b7name,b9name,'autorouting','on')
				elseif b1mcon2 == 10
					add_line(sys,b7name,b10name,'autorouting','on')
				newcount= newcount + 1;
				end
			end
        end
        c1count = ('How many blocks is the output of block8 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b8name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b8name,b2neg_3,'autorouting','on')
                end
            else
                add_line(sys,b8name,b9name,'autorouting','on')
            end
        elseif c1con > 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            newcount = 1;
            while newcount <= c1con
                if out1 == 1
                    disp('1:+, 2:-');
                    sum_pon = ('Does this connect to + or - feedback: ');
                    spon = input(sum_pon);
                    if spon == 1
                        add_line(sys,b1name,b2pos_1,'autorouting','on')
                    elseif spon ==2
                        add_line(sys,b1n,b2neg_1,'autorouting','on')
                    end
                    disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                    ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                    b1multcon1 = ('Enter Next connection: ');
                    b1mcon1 = input(b1multcon1);
                    if b1mcon1 == 2
                        add_line(sys,b8name,b2name,'autorouting','on')
                    elseif b1mcon1 == 3
                        add_line(sys,b8name,b3name,'autorouting','on')
                    elseif b1mcon1 == 4
                        add_line(sys,b8name,b4name,'autorouting','on')
                    elseif b1mcon1 == 5
                        add_line(sys,b8name,b5name,'autorouting','on')
                    elseif b1mcon1 == 6
                        add_line(sys,b8name,b6name,'autorouting','on')
                    elseif b1mcon1 == 7
                        add_line(sys,b8name,b7name,'autorouting','on')
                    elseif b1mcon1 == 8
                        add_line(sys,b8name,b8name,'autorouting','on')
                    elseif b1mcon1 == 9
                        add_line(sys,b8name,b9name,'autorouting','on')
                    elseif b1mcon1 == 10
                        add_line(sys,b8name,b10name,'autorouting','on')
                    newcount= newcount + 1;
                    end
                end
            end
        end
        c1count = ('How many blocks is the output of block9 connected to: ');
        c1con = input(c1count);
        if c1con == 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            if out1 == 1
                disp('1:+, 2:-');
                sum_pon = ('Does this connect to + or - feedback: ');
                spon = input(sum_pon);
                if spon == 1
                    add_line(sys,b1name,b2pos_1,'autorouting','on')
                elseif spon ==2
                    add_line(sys,b1n,b2neg_1,'autorouting','on')
                end
            else
                add_line(sys,b9name,b10name,'autorouting','on')
            end
        elseif c1con > 1
            disp('1:YES, 2:NO');
            out1con = ('Is this connected to a summing junction: ');
            out1 = input(out1con);
            newcount = 1;
            while newcount <= c1con
                if out1 == 1
                    disp('1:+, 2:-');
                    sum_pon = ('Does this connect to + or - feedback: ');
                    spon = input(sum_pon);
                    if spon == 1
                        add_line(sys,b1name,b2pos_1,'autorouting','on')
                    elseif spon ==2
                        add_line(sys,b1n,b2neg_1,'autorouting','on')
                    end
                    disp(['2:',b2n,', 3:',b3n,', 4:',b4n,', 5:',b5n,', 6:',b6n...
                    ', 7:',b7n,', 8:',b8n,', 9:',b9n,', 10:',b10n]);
                    b1multcon1 = ('Enter Next connection: ');
                    b1mcon1 = input(b1multcon1);
                    if b1mcon1 == 2
                        add_line(sys,b9name,b2name,'autorouting','on')
                    elseif b1mcon1 == 3
                        add_line(sys,b9name,b3name,'autorouting','on')
                    elseif b1mcon1 == 4
                        add_line(sys,b9name,b4name,'autorouting','on')
                    elseif b1mcon1 == 5
                        add_line(sys,b9name,b5name,'autorouting','on')
                    elseif b1mcon1 == 6
                        add_line(sys,b9name,b6name,'autorouting','on')
                    elseif b1mcon1 == 7
                        add_line(sys,b9name,b7name,'autorouting','on')
                    elseif b1mcon1 == 8
                        add_line(sys,b9name,b8name,'autorouting','on')
                    elseif b1mcon1 == 9
                        add_line(sys,b9name,b9name,'autorouting','on')
                    elseif b1mcon1 == 10
                        add_line(sys,b9name,b10name,'autorouting','on')
                    newcount= newcount + 1;
                    end
                end
            end
        end
    end