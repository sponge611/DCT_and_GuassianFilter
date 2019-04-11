imdata = imread("cat3_LR.png");
imdata = double(imdata)/255;
G = fspecial('gaussian',[7 7],1);
height = size(imdata,1);
width = size(imdata,2);
imdata_expand = zeros(height+6,width+6,3);
imdata_expand(4:height+3,4:width+3,:) = imdata(:,:,:);

for rgb = 1:3
    for i = 4:height+3
        for j = 4:width+3
            g = 0.0;
            for m = 1:7
                for n = 1:7
                    g = g + imdata_expand(i+m-4,j+n-4,rgb)*G(m,n);
                end
            end
            imdata_expand(i,j,rgb) = g;
        end
    end
end

show = imdata_expand(4:height+3,4:width+3,:);
subplot(1,2,1), imshow(show);
subplot(1,2,2), imshow(imdata);
imwrite(show,"cat3_LR_gaussian_sigma1_77.jpg");

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