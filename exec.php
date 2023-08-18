<?php
if (
    !file_exists('bin/obfuscate.php') ||
    !file_exists('bin/colors.php') ||
    !file_exists('bin/header.php')
) {
    echo "\nSome Files Missing, Please Download The Tool Again\nYou Can Download it With This Command:\n";
    echo "git clone https://github.com/serainox420/Blind-Bash-v2\n\n";
    exit(0);
} else {
    require('bin/obfuscate.php');
    require('bin/colors.php');
    require('bin/header.php');
}

head();
$filename = readline(" > Enter Input File Name: ");
$filename = trim($filename);

if (!file_exists($filename)) {
    echo "$filename Does Not Exist\n";
    exit(1);
}

$initialSize = filesize($filename);
$initialContents = file_get_contents($filename);

$repeatCount = (int)readline("  ~ Enter Number of Repeats: ");
if ($repeatCount <= 0) {
    echo "Invalid repeat count\n";
    exit(1);
}

for ($i = 0; $i < $repeatCount; $i++) {
    $out = dirname(__FILE__) . DIRECTORY_SEPARATOR . $filename;
    obfuscate($filename, $out);
    echo "Obfuscation round $i complete.\n";
}

$processedSize = filesize($filename);
$processedContents = file_get_contents($filename);

echo "\nInitial Size: $initialSize bytes, Characters: " . strlen($initialContents) . PHP_EOL;
echo "Processed Size: $processedSize bytes, Characters: " . strlen($processedContents) . PHP_EOL;
echo "Obfuscation process completed.\n";
?>
