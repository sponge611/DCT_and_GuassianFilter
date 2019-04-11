imdata = imread("cat3_LR.png");
imdata = double(imdata)/255;
G = fspecial('gaussian',[5 5],5);
height = size(imdata,1);
width = size(imdata,2);
imdata_expand = zeros(height+4,width+4,3);
imdata_expand(3:height+2,3:width+2,:) = imdata(:,:,:);

for rgb = 1:3
    for i = 3:height+2
        for j = 3:width+2
            g = 0.0;
            for m = 1:5
                for n = 1:5
                    g = g + imdata_expand(i+m-3,j+n-3,rgb)*G(m,n);
                end
            end
            imdata_expand(i,j,rgb) = g;
        end
    end
end

show = imdata_expand(3:height+2,3:width+2,:);
subplot(1,2,1), imshow(show);
subplot(1,2,2), imshow(imdata);
imwrite(show,"cat3_LR_gaussian_sigma5_55.jpg");

SE = 0;
for rgb = 1:3
    for i = 1:height
        for j = 1:width
            SE = SE + (imdata(i,j,rgb)*255 - show(i,j,rgb)*255)^2;
        end
    end
end
MSE = SE/(height*width*3);
PSNR = 10 * log10(255^2/MSE);
disp("psnr:");
disp(PSNR);