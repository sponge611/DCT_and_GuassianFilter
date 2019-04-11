imdata = imread("cat3_LR.png");
imdata = double(imdata)/255;
G = fspecial('gaussian',[3 3],1);
height = size(imdata,1);
width = size(imdata,2);
imdata_expand = zeros(height+2,width+2,3);
imdata_expand(2:height+1,2:width+1,:) = imdata(:,:,:);

for rgb = 1:3
    for i = 2:height+1
        for j = 2:width+1
            g = 0.0;
            for m = 1:3
                for n = 1:3
                    g = g + imdata_expand(i+m-2,j+n-2,rgb)*G(m,n);
                end
            end
            imdata_expand(i,j,rgb) = g;
        end
    end
end

show = imdata_expand(2:height+1,2:width+1,:);
subplot(1,2,1), imshow(show);
subplot(1,2,2), imshow(imdata);

imwrite(show,"cat3_LR_gaussian_sigma1_33.jpg");

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
