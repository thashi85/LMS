class PaymentSummary {
  late double dueAmount;
  late DateTime dueDate;
  List<Payment> payments=[];

  PaymentSummary({required this.dueAmount,required this.dueDate});

  PaymentSummary.fromJson(Map<String, dynamic> json) {
    if(json['dueAmount']!=null){
      dueAmount = json['dueAmount'] * 1.0;
    }
    dueDate = DateTime.parse(json['dueDate']);
    if (json['transaction'] != null) {
      payments = <Payment>[];
      json['transaction'].forEach((v) {
        payments.add(Payment.fromJson(v));
      });
    }
  }

  
}

class Payment {
  late double paidAmount;
  late DateTime paidDate;

  Payment({required this.paidAmount,required this.paidDate});

  Payment.fromJson(Map<String, dynamic> json) {
    paidAmount = double.parse((json['paidAmount']??0.0).toString());
    paidDate = DateTime.parse( json['paidDate']);
  }

  
}