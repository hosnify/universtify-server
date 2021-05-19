const faker = require("faker");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const arabicNames = [
  "Ahmed",
  "Mohamed",
  "Sameh",
  "Karim",
  "Omar",
  "Abdelrahman",
  "Mahmoud",
  "Hosni",
  "Hussin",
  "Ali",
  "Kamal",
];
const studentData = Array.from({ length: 100 }).map(() => ({
  fname: arabicNames[faker.datatype.number({ min: 0, max: 10 })],
  lname: arabicNames[faker.datatype.number({ min: 0, max: 10 })],
  gender: "MALE",
  password: faker.internet.password(),
  email: faker.internet.email(),
  level: faker.datatype.number({ min: 1, max: 5 }),
  semester: "SUMMER",
  major: "MIS",
  creditDone: faker.datatype.number({ min: 20, max: 200 }),
  creditHave: faker.datatype.number({ min: 12, max: 20 }),
  supervisorId: faker.datatype.number({ min: 1, max: 99 }),
  GPA: faker.datatype.float({ min: 0, max: 4, precision: 0.2 }),
  lastTermGPA: faker.datatype.float({ min: 0, max: 4, precision: 0.2 }),
}));
const supervisorData = Array.from({ length: 100 }).map(() => ({
  fname: arabicNames[faker.datatype.number({ min: 0, max: 10 })],
  lname: arabicNames[faker.datatype.number({ min: 0, max: 10 })],
  gender: "MALE",
  password: faker.internet.password(),
  email: faker.internet.email(),
  phone: faker.phone.phoneFormats(),
}));
const courseData = Array.from({ length: 100 }).map(() => ({
  name: faker.commerce.productName(),
  level: faker.datatype.number({ min: 1, max: 5 }),
  discreption: faker.lorem.paragraph(5),
  credit: faker.datatype.number({ min: 1, max: 4 }),
  courseCode: "MIS" + faker.datatype.number(100).toString(),
}));

const finishedCoursesData = Array.from({ length: 100 }).map(() => ({
  courseId: faker.datatype.number({ min: 1, max: 100 }),
  studentID: faker.datatype.number({ min: 1, max: 100 }),
  grade: faker.datatype.float({ min: 0, max: 4, precision: 0.2 }),
  semester: ["FALL", "SPRING", "SUMMER"][
    faker.datatype.number({ min: 0, max: 2 })
  ],
  instructorName:
    "DR. " +
    arabicNames[faker.datatype.number({ min: 0, max: 10 })] +
    " " +
    arabicNames[faker.datatype.number({ min: 0, max: 10 })],
}));

const enrollmentData = Array.from({ length: 100 }).map(() => ({
  supervisorId: faker.datatype.number({ min: 1, max: 100 }),
  studentID: faker.datatype.number({ min: 1, max: 100 }),
  courseID: faker.datatype.number({ min: 1, max: 100 }),
}));

async function main() {
  // const createManySuperVisors = await prisma.supervisor
  //   .createMany({
  //     data: supervisorData,
  //     skipDuplicates: true,
  //   })
  //   .then(async () => {
  //     const createManyCourses = await prisma.course.createMany({
  //       data: courseData,
  //       skipDuplicates: true,
  //     });
  //   })
  //   .then(async () => {
  //     const createManyStudent = await prisma.student.createMany({
  //       data: studentData,
  //       skipDuplicates: true,
  //     });
  //   })
  //   .then(async () => {
  //     const createManyEnrollments = await prisma.enrollment.createMany({
  //       data: enrollmentData,
  //       skipDuplicates: true,
  //     });
  //   })
  //   .then(async () => {
  //     const createManyFinishedCourses = await prisma.finishedCourses.createMany(
  //       {
  //         data: finishedCoursesData,
  //         skipDuplicates: true,
  //       }
  //     );
  //   });
  const createManyFinishedCourses = await prisma.finishedCourses.createMany({
    data: finishedCoursesData,
    skipDuplicates: true,
  });
  // for (let level = 2; level <= 5; level++) {
  //   const getStudentBylevel = (await prisma.student.findMany()).map(
  //     (student) => student.id
  //   );
  //   const getcoursesBylevel = (
  //     await prisma.course.findMany({ where: { level: level - 1 } })
  //   ).map((course) => course.id);
  // }

  // for (let level = 2; level <= 5; level++) {
  //   const getCoursesByLevel = (
  //     await prisma.course.findMany({ where: { level: level - 1 } })
  //   )
  //     .map((course) => {
  //       return { id: course.id };
  //     })
  //     .filter((_, index) => index < 2); //take 3 elemnts only
  //   const getCoursesForPrevLevel = (
  //     await prisma.course.findMany({ where: { level } })
  //   )
  //     .map((course) => course.id)
  //     .forEach(async (id) => {
  //       await prisma.course.update({
  //         where: {
  //           id,
  //         },
  //         data: {
  //           prerequisites: {
  //             connect: getCoursesByLevel,
  //           },
  //         },
  //       });
  //     });
  // }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
