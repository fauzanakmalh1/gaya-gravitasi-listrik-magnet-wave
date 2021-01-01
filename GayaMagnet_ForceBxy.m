function GayaMagnet_ForceBxy()
% clc, clear, clf

% =================
% Initialize SETUP
% =================
% Figure Properties
% 'Position',[left bottom width height]
set(gcf,'units','normal','position',[.2 .2 .5 .5], ...
    'KeyPressFcn',@f_keyPress,'color', [1 1 1]);

% Axis Properties
bound = [0 200 0 100];
set(gca,'color','black', ...
    'XLim',[bound(1) bound(2)],'YLim',[bound(3) bound(4)], ...
    'XTick',[],'YTick',[],'nextplot','add')
daspect([1 1 1])
box on

% NPM 05 Huruf F
% Generate BLOCK
global posX posY;
posX = 50; posY = 50;
posXm2 = bound(2)/2; posYm2 = bound(4)/2;
objX = [0 0 4 4 1 1 3 3 1 1];
objY = [0 6 6 5 5 4 4 3 3 0];
blockVertices = @(x,y) [objX'+x objY'+y];
blockObj = patch('Vertices', blockVertices(posX,posY), ...
    'Faces',[1 2 3 4 5 6 7 8 9 10], 'FaceColor', [mod(0,2) mod(5,2) mod(05,2)]);
blockObjM = patch('Vertices', blockVertices(posXm2,posYm2), ...
    'Faces',[1 2 3 4 5 6 7 8 9 10],'FaceColor', [0 .5 1]);

% =================
% MAIN LOOP
% =================
global vx vy vz Bx By Bz
vx = 0; vy = 0; vz = 0;
Bx = 0; By = 0; Bz = 0;
m1 = 1; m2 = 1e3;
q = -1.0;
dt = 1.0;
while 0 < 1
    tic;

    % Movement
    vx = vx - q*(vy*Bz - vz*By)*dt;
    vy = vy - q*(vz*Bx - vx*Bz)*dt;
    posX = posX + vx;
    posY = posY + vy;

    % Boundary Conditions
    if (posX < bound(1)) || (posX > bound(2))
        vx = -vx;
    end
    if (posY < bound(3)) || (posY > bound(4))
        vy = -vy;
    end

    % Update Object Coordinate
    set(blockObj,'Vertices',blockVertices(posX,posY));

    pause(1/60 - toc); % 60 fps
end
end

% =========================================================================
function f_keyPress(~,event)
global posX posY vx vy vz Bx By Bz

switch event.Key
    case 'leftarrow'
        vx = vx - 1;
        vy = vy;
    case 'rightarrow'
        vx = vx + 1;
        vy = vy;
    case 'uparrow'
        vx = vx;
        vy = vy + 1;
    case 'downarrow'
        vx = vx;
        vy = vy - 1;
    case 'space'
        vx = 0;
        vy = 0;
        Bx = 0;
        By = 0;
        Bz = 0;
    case 'r'
        posX = 100;
        posY = 50;
        Bx = 0;
        By = 0;
        Bz = 0;
    case 'g'
        if (Bz <= 0)
            Bz = 1.0e-1;
        elseif (Bz > 0)
            Bz = -1.0e-1;
        end
    case 'q'
        Bz = rand - 0.5;
end

end