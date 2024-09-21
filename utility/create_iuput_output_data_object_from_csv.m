function object = create_iuput_output_data_object_from_csv(file, dt)
    data = readmatrix(file);
    input = data(:, 3);
    output = data(:, 4);
    object = iddata(output, input, dt);
end