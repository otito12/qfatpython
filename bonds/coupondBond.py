class CouponBond:

    def __init__(self, principal: float, rate: float, maturity: float, interest_rate: float):
        self.principal = principal
        self.rate = rate / 100
        self.maturity = maturity
        self.interest_rate = interest_rate / 100

    def peresent_value(self, x, c, n):
        return sum([c/(1+self.interest_rate)**i for i in list(range(1, n+1))]) + (x/(1+self.interest_rate)**n)

    def calculate_price(self):
        return self.peresent_value(x=self.principal, c=self.principal * self.rate, n=self.maturity)


if __name__ == "__main__":
    c_bond = CouponBond(principal=1000, maturity=3, interest_rate=4, rate=10)
    print("{}".format(round(c_bond.calculate_price(), 2)))
