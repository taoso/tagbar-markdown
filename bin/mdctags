#!/usr/bin/env php
<?php
if (!isset($argv[2])) {
    echo <<<EOL
!_TAG_FILE_FORMAT       2       /extended format; --format=1 will not append ;" to lines/'
!_TAG_FILE_SORTED       0       /0=unsorted, 1=sorted, 2=foldcase/'
!_TAG_PROGRAM_AUTHOR    lvht /git@lvht.net/'
!_TAG_PROGRAM_NAME      mdctags        //'
!_TAG_PROGRAM_URL       https://github.com/lvht/tagbar-markdown /official site/'
!_TAG_PROGRAM_VERSION   0.1.0   //'

EOL;
}

if (isset($argv[1])) {
    $f = new SplFileObject($argv[1]);

    $path = $f->getRealPath();
    $stack = [];
    $in_code = false;

    $lineNo = 0;
    foreach ($f as $line) {
        ++$lineNo;
        if (preg_match('/^```/', $line)) {
            $in_code = !$in_code;
        }
        if (!$in_code && preg_match('/^(#+)\s+(\S.*)$/', rtrim($line), $matches)) {
            $title = $matches[2];
            $anchor = $matches[0];

            $line = [
                'title' => $matches[2],
                'level' => strlen($matches[1]),
            ];

            if (count($stack) == 0) {
                array_unshift($stack, $line);
            } elseif ($stack[0]['level'] < $line['level']) {
                array_unshift($stack, $line);
            } else {
                while (count($stack) && $stack[0]['level'] >= $line['level']) {
                    array_shift($stack);
                }
                array_unshift($stack, $line);
            }

            $scopes = array_map(function ($line) { return $line['title']; }, array_reverse($stack));
            array_pop($scopes);
            $scopesStr = implode('::', $scopes);
            $level = $line['level'];
            if (count($stack) < 2) {
                $plevel = $level > 1 ? $level - 1 : 0;
            } else {
                $parent = $stack[1];
                $plevel = $parent['level'];
            }
            $scope = $scopesStr ? "h$plevel:$scopesStr" : '';
            $type = chr(0x60 + $level);

            if (isset($argv[2])) {
                if ($level > 1) {
                    $title = $matches[2];
                    echo str_pad('', strlen($matches[1])-2, ' ')."- [$title](#$title)\n";
                }
            } else {
                echo "$title\t$path\t/^$anchor\$/;\"\t$type\tline:$lineNo\t$scope\n";
            }
        }
    }
}
