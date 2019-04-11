imdata = imread("cat2_gray.png");
height = size(imdata,1);
width = size(imdata,2);
expand_imdata = uint8(zeros(height+2,width+2));

for row = 2:height+1
    for column = 2:width+1
        expand_imdata(row,column) = imdata(row-1,column-1);
    end
end

for row = 2:height+1
    for column = 2:width+1
        p = expand_imdata(row,column);
        if p < 128
            e = p;
        else
            e = p - 255;
        end
        expand_imdata(row,column+1) = expand_imdata(row,column+1) + (7/16)*e;
        expand_imdata(row+1,column-1) = expand_imdata(row+1,column-1) + (3/16)*e;
        expand_imdata(row+1,column) = expand_imdata(row+1,column) + (5/16)*e;
        expand_imdata(row+1,column+1) = expand_imdata(row+1,column+1) + (1/16)*e;
    end
end

imdata = expand_imdata(2:height+1,2:width+1);
for row = 1:height
    for column = 1:width
        if imdata(row,column) < 128
            imdata(row,column) = 0;
        else
            imdata(row,column) = 255;
        end
    end
end
imshow(imdata);
imwrite(imdata,"error_diffusion_dithering.jpg")
