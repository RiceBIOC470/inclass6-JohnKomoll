%Inclass asssignment 6. 

%1. a. Write a function which takes as inputs: a. a cell array of names. b.
% an array of numbers with the ages corresponding to the names, and c. a binary
% variable which is a P/F grade (true for pass) and returns a structure
% array called students with one structure storing this information for each student. b. Write a
% function which takes your structure array of students as input and returns
% the average age of the students. 

% Initialize random class data
names = {'Joe', 'Sally', 'Dave', 'Amanda'};
ages = [20, 25, 19, 23];
pass = [true, false, true, true];

% Call function for Part a
students = student_info(names, ages, pass);

% Get average age of students with function call for Part b
average_student_age = average_age(students);


%2. In this folder, you will find an immunofluorescence image of human stem
%cells stained for a gene called SOX2. Write a function which takes a
%filename as input and returns a structure containing metaData. Include at
%least the bitdepth, size, and date the image was taken. Do not include any
%information you do not understand. Hint: use the builtin function imfinfo
%b. Look at the field ImageDescription in the output of imfinfo - there is
%a lot of information here. Write code that gets the actual temperature
%from the camera out of this field. (Hint: it is preceded by the words
%"Actual Temperature" which don't appear anywhere else in
%ImageDescription). 

% Name the image to investigate and use the function written for #2 to
% analyze the image.
image_name = '160611-AntiNodal-SD20x_f0003_w0002.tif';
metaData = image_analyze(image_name);

% Retrieve the temperature of the camera from the image
image_info = imfinfo(image_name);
image_desc = image_info.ImageDescription;
temp_data_location = strfind(image_desc, 'Actual Temperature');
index = temp_data_location + 19;
camera_temp = str2double(image_desc(index:(index + 2)));

% Display camera temp info and where it was discovered
fprintf('The temperature of the camera at the time that the image was taken was %d. \n', camera_temp)
fprintf('The info from the file ImageDescription looks like: \n')
fprintf([image_desc(temp_data_location:index+2), ' \n'])


% FUNCTIONS %

% Number 1 Part a
function [students] = student_info( names, ages, pass )

% Turn the ages and pass into a cell array to supply to the students structure
ages = num2cell(ages);
pass = num2cell(pass);

% Create a structure out of the supplied data
students = struct('name', names, 'age', ages, 'status', pass);

end

% Number 1 Part b
function [ave] = average_age( student_structure )

% Take the average of all the age entries
ave = mean([student_structure.age]);

end

% Number 2
function [ metaData ] = image_analyze( image_name )

% Use MATLAB's imfinfo to get a structure with some data on the image
info = imfinfo(image_name);

% Save relevant and useful data on the image into a new structure
metaData.filesize = info.FileSize;
metaData.bitdepth = info.BitDepth;
metaData.width = info.Width;
metaData.height = info.Height;
metaData.date = info.FileModDate;
metaData.type = info.ColorType;
metaData.format = info.Format;
metaData.units = info.ResolutionUnit;
metaData.maxval = info.MaxSampleValue;
metaData.minval = info.MinSampleValue;

end


