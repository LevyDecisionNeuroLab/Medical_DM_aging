%% Caliberation
function TrackerCaliberation
% *************************************************************************
%
% Initialization and connection to the Tobii Eye-tracker
%
% *************************************************************************
Tobii = EyeTrackingOperations();

eyetracker_address = 'tet-tcp://169.254.6.122';

eyetracker = Tobii.get_eyetracker(eyetracker_address);

if isa(eyetracker,'EyeTracker')
    disp(['Address:',eyetracker.Address]);
    disp(['Name:',eyetracker.Name]);
    disp(['Serial Number:',eyetracker.SerialNumber]);
    disp(['Model:',eyetracker.Model]);
    disp(['Firmware Version:',eyetracker.FirmwareVersion]);
    disp(['Runtime Version:',eyetracker.RuntimeVersion]);
else
    disp('Eye tracker not found!');
end

screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
screen_pixels = [screenXpixels screenYpixels];
[xCenter, yCenter] = RectCenter(windowRect);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
% *************************************************************************
%
% Calibration of a participant
%
% *************************************************************************

% Dot size in pixels
dotSizePix = 40;

% Start collecting data
% The subsequent calls return the current values in the stream buffer.
% If a flat structure is prefered just use an extra input 'flat'.
% i.e. gaze_data = eyetracker.get_gaze_data('flat');
eyetracker.get_gaze_data();

Screen('TextSize', window, 20);

while ~KbCheck

    DrawFormattedText(window, 'When correctly positioned press any key to start the calibration.', 'center', screenYpixels * 0.1, white);

    distance = [];

    gaze_data = eyetracker.get_gaze_data();

    if ~isempty(gaze_data)
        last_gaze = gaze_data(end);

        validityColor = [255 0 0];

        % Check if user has both eyes inside a reasonable tacking area.
        if last_gaze.LeftEye.GazeOrigin.Validity.value && last_gaze.RightEye.GazeOrigin.Validity.value
            left_validity = all(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) < 0.85) ...
                                 && all(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) > 0.15);
            right_validity = all(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) < 0.85) ...
                                 && all(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) > 0.15);
            if left_validity && right_validity
                validityColor = [0 255 0];
            end
        end

        origin = [screenXpixels/4 screenYpixels/4];
        size = [screenXpixels/2 screenYpixels/2];

        penWidthPixels = 3;
        baseRect = [0 0 size(1) size(2)];
        frame = CenterRectOnPointd(baseRect, screenXpixels/2, yCenter);

        Screen('FrameRect', window, validityColor, frame, penWidthPixels);
        % Left Eye
        if last_gaze.LeftEye.GazeOrigin.Validity.value
            distance = [distance; round(last_gaze.LeftEye.GazeOrigin.InUserCoordinateSystem(3)/10,1)];
            left_eye_pos_x = double(1-last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1))*size(1) + origin(1);
            left_eye_pos_y = double(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(2))*size(2) + origin(2);
            Screen('DrawDots', window, [left_eye_pos_x left_eye_pos_y], dotSizePix, validityColor, [], 2);
        end
        % Right Eye
        if last_gaze.RightEye.GazeOrigin.Validity.value
            distance = [distance;round(last_gaze.RightEye.GazeOrigin.InUserCoordinateSystem(3)/10,1)];
            right_eye_pos_x = double(1-last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1))*size(1) + origin(1);
            right_eye_pos_y = double(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(2))*size(2) + origin(2);
            Screen('DrawDots', window, [right_eye_pos_x right_eye_pos_y], dotSizePix, validityColor, [], 2);
        end
        pause(0.05);
    end
    DrawFormattedText(window, sprintf('Current distance to the eye tracker: %.2f cm.',mean(distance)), 'center', screenYpixels * 0.85, white);
    % Flip to the screen. This command basically draws all of our previous
    % commands onto the screen.
    % For help see: Screen Flip?
    Screen('Flip', window);

end

eyetracker.stop_gaze_data();


spaceKey = KbName('Space');
RKey = KbName('R');

dotSizePix = 40;

dotColor = [[255 0 0];[255 255 255]]; % Red and white

leftColor = [255 0 0]; % Red
rightColor = [0 0 255]; % Bluesss

% Calibration points
lb = 0.1;  % left bound
xc = 0.5;  % horizontal center
rb = 0.9;  % right bound
ub = 0.1;  % upper bound
yc = 0.5;  % vertical center
bb = 0.9;  % bottom bound

points_to_calibrate = [[lb,ub];[rb,ub];[xc,yc];[lb,bb];[rb,bb]];

% Create calibration object
calib = ScreenBasedCalibration(eyetracker);

calibrating = true;

while calibrating
    % Enter calibration mode
    calib.enter_calibration_mode();

    for i=1:length(points_to_calibrate)

        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, dotSizePix, dotColor(1,:), [], 2);
        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, dotSizePix*0.5, dotColor(2,:), [], 2);

        Screen('Flip', window);

        % Wait a moment to allow the user to focus on the point
        pause(1);

        if calib.collect_data(points_to_calibrate(i,:)) ~= CalibrationStatus.Success
            % Try again if it didn't go well the first time.
            % Not all eye tracker models will fail at this point, but instead fail on ComputeAndApply.
            calib.collect_data(points_to_calibrate(i,:));
        end

    end

    DrawFormattedText(window, 'Calculating calibration result....', 'center', 'center', white);

    Screen('Flip', window);

    % Blocking call that returns the calibration result
    calibration_result = calib.compute_and_apply();

    calib.leave_calibration_mode();

    if calibration_result.Status ~= CalibrationStatus.Success
        break
    end

    % Calibration Result

    points = calibration_result.CalibrationPoints;

    for i=1:length(points)
        Screen('DrawDots', window, points(i).PositionOnDisplayArea.*screen_pixels, dotSizePix*0.5, dotColor(2,:), [], 2);
        for j=1:length(points(i).RightEye)
            if points(i).LeftEye(j).Validity == CalibrationEyeValidity.ValidAndUsed
                Screen('DrawDots', window, points(i).LeftEye(j).PositionOnDisplayArea.*screen_pixels, dotSizePix*0.3, leftColor, [], 2);
                Screen('DrawLines', window, ([points(i).LeftEye(j).PositionOnDisplayArea; points(i).PositionOnDisplayArea].*screen_pixels)', 2, leftColor, [0 0], 2);
            end
            if points(i).RightEye(j).Validity == CalibrationEyeValidity.ValidAndUsed
                Screen('DrawDots', window, points(i).RightEye(j).PositionOnDisplayArea.*screen_pixels, dotSizePix*0.3, rightColor, [], 2);
                Screen('DrawLines', window, ([points(i).RightEye(j).PositionOnDisplayArea; points(i).PositionOnDisplayArea].*screen_pixels)', 2, rightColor, [0 0], 2);
            end
        end

    end

    DrawFormattedText(window, 'Press the ''R'' key to recalibrate or ''Space'' to continue....', 'center', screenYpixels * 0.95, white)

    Screen('Flip', window);

    while 1.
        [ keyIsDown, seconds, keyCode ] = KbCheck;
        keyCode = find(keyCode, 1);

        if keyIsDown
            if keyCode == spaceKey
                calibrating = false;
                break;
            elseif keyCode == RKey
                break;
            end
            KbReleaseWait;
        end
    end
end
end
