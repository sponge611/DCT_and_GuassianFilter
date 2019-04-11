imdata = imread("cat2_gray.png");
height = size(imdata,1);
width = size(imdata,2);
average = 0;
for row = 1:height
    for column = 1:width
        int = double(imdata(row,column));
        average = average + int;
    end
end

average = average / height / width;

for row = 1:height
    for column = 1:width
        if imdata(row,column) > average
            imdata(row,column) = 255;
        else
            imdata(row,column) = 0;
        end
    end
end

imshow(imdata);

imwrite(imdata,"average_dithering.jpg")