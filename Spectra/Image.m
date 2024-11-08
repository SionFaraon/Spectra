classdef Image
    properties
        image
    end
    
    methods
        function obj = Image(Path)
            %Constructor
            obj.image = imread(Path);
        end
        
        function obj = Flip(obj, Direction)
            switch lower(Direction)
                case "horizontal"
                    obj.image = obj.image(1:end, end:-1:1, 1:3);
                case "vertical"
                    obj.image = obj.image(end:-1:1, 1:end, 1:3); 
                otherwise
                    error("Direction can be horizontal or vertical");
            end
        end
        
        function obj = Rotate(obj, Degrees)
            tetha = Degrees * (pi/180);
            R = [cos(tetha) -sin(tetha); sin(tetha) cos(tetha)];
            [width, height, n] = size(obj.image);
            
            dim = max(width,height);
            imgAux = zeros(dim, dim, n, 'like', obj.image);

            for i=1:height
                for j=1:width
                    v = R * ([i - (dim/2); j - (dim/2)]);
                    X = round(v(1) + dim/2);
                    Y = round(v(2) + dim/2);
                    
                    if X > 0 && X <= dim && Y > 0 && Y <= dim
                        imgAux(X, Y, :) = obj.image(i, j, :); 
                    end
                end
            end
            obj.image(:,:,:) = imgAux(:,:,:);
        end

        function resImage = Zoom(obj, zoomFactor, zoomPoint)
            [width, height, ~] = size(obj.image);
            
        end
        
    end
end

