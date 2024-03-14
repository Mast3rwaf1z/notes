function NextDate(d::Int, m::Int, y::Int)
    if d <= 0 || m <= 0 || m >= 13
        throw(ArgumentError("invalid input"))
    end

    if m == 2
        num_days = IsLeapYear(y) ? 29 : 28
    else
        num_days = m ∈ (4, 6, 9, 11) ? 30 : 31
    end

    if d < num_days
        d += 1
    elseif d == num_days
        d = 1
        if m < 12
            m += 1
        else
            m = 1
            y += 1
        end
    else
        throw(ArgumentError("invalid input"))
    end
    return (d, m, y)
end

function IsLeapYear(y::Int)
    return y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)
end

nothing
