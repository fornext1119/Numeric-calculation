# ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
function sn($a, $lim)
{
    $n = [math]::floor($lim / $a) # ����:n  =  ���:lim / ����:a
    $l = $n * $a                  # ����:l  =  ����:n   * ����:a
    ($a + $l) * $n / 2            # ���a:sn = (����:a   + ����:l) * ����:n / 2
}

# 3 �̔{���̍��v
Write-Host (sn 3 999)
