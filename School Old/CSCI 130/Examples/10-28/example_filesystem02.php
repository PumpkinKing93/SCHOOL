<<<<<<< HEAD
<?php

$arr = array(
    array ( 1531412763, 1439959339 ),
    array ( 123, 456, 789 ),
);

$file_w = fopen('binint', 'w+');

// Creating file content : concatenation of binary strings 
$bin_str = '';
foreach ($arr as $inner_array_of_int) {
    foreach ($inner_array_of_int as $num) {
        // Use of i format (integer). If you want to change format
        // according to the value of $num, you will have to save the
        // format too.
        $bin_str .= pack('i', $num);
		// http://php.net/manual/en/function.pack.php pack: Pack data into binary string
    }

    $bin_str .= "\n";
}

fwrite($file_w, $bin_str);
fclose($file_w);

// Now read and test. $lines_read will contain an array like the original.
$lines_read = [];
// We use file function to read the file as an array of lines.
$file_r = file('binint');

// Unpack all lines
foreach ($file_r as $line) {
    // Format is i* because we may have more than 1 int in the line
    // If you changed format while packing, you will have to unpack with the
    // corresponding same format
    $lines_read[] = unpack('i*', $line);
	// http://php.net/manual/en/function.unpack.php unpack: Unpack data from binary string
}

var_dump($lines_read);

=======
<?php

$arr = array(
    array ( 1531412763, 1439959339 ),
    array ( 123, 456, 789 ),
);

$file_w = fopen('binint', 'w+');

// Creating file content : concatenation of binary strings 
$bin_str = '';
foreach ($arr as $inner_array_of_int) {
    foreach ($inner_array_of_int as $num) {
        // Use of i format (integer). If you want to change format
        // according to the value of $num, you will have to save the
        // format too.
        $bin_str .= pack('i', $num);
		// http://php.net/manual/en/function.pack.php pack: Pack data into binary string
    }

    $bin_str .= "\n";
}

fwrite($file_w, $bin_str);
fclose($file_w);

// Now read and test. $lines_read will contain an array like the original.
$lines_read = [];
// We use file function to read the file as an array of lines.
$file_r = file('binint');

// Unpack all lines
foreach ($file_r as $line) {
    // Format is i* because we may have more than 1 int in the line
    // If you changed format while packing, you will have to unpack with the
    // corresponding same format
    $lines_read[] = unpack('i*', $line);
	// http://php.net/manual/en/function.unpack.php unpack: Unpack data from binary string
}

var_dump($lines_read);

>>>>>>> 3c23027f6d2ee9146a630164e604e1edfb3d267b
?>