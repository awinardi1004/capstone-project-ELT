{% macro get_coupon_code(coupon_status, coupon_code) %}
    case 
        when {{ coupon_status }} = 'Used' then {{ coupon_code }}
        else 'not used'
    end
{% endmacro %}