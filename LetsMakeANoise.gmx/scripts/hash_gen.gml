///hash_gen(STR)
var str = argument0;

//WHY THE FUCK GM:S DOESN'T SUPPORT
//DARN UNSIGNED INTERGER VALUES
var hashBuffer = buffer_create(2, buffer_fixed, 2);
var char = 0;
var prevHash = 0;
var val = 0;

buffer_seek(hashBuffer, buffer_seek_start, 0);
buffer_write(hashBuffer, buffer_u16, 0);

//Generate SDBM hash
for (var i=1;i<=string_length(str);i++)
{
    char = real(string_ord_at(str, i));
    
    buffer_seek(hashBuffer, buffer_seek_start, 0);
    prevHash = buffer_read(hashBuffer, buffer_u16);
    
    val = char + (prevHash << 6) + (prevHash << 16) - prevHash;
    buffer_seek(hashBuffer, buffer_seek_start, 0);
    buffer_write(hashBuffer, buffer_u16, val);
}

buffer_seek(hashBuffer, buffer_seek_start, 0);
var result = buffer_read(hashBuffer, buffer_u16);

buffer_delete(hashBuffer);
return result;
