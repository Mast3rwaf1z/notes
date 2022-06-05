#include <QApplication>
#include <QVBoxLayout>
#include <QWidget>
#include <QPushButton>
#include <string>
#include <iostream>
using namespace std;
int floor_count = 10;

int main(int argc, char** argv){
    cout << "Started gui" << endl;
    QApplication app(argc, argv);
    QWidget window(NULL);

    QVBoxLayout layout(NULL);
    for(int i = 0; i < floor_count; i++){
        QPushButton *button = new QPushButton(to_string(i).c_str());
        string command = "echo " + to_string(i) + " >> /dev/ttyACM1";
        app.connect(button, &QPushButton::clicked, &app, [command]{
            system(command.c_str());
        });
        layout.addWidget(button);
    }

    window.setLayout(&layout);
    window.show();
    return app.exec();
}